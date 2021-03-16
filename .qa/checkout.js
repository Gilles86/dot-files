#!/usr/bin/node
var my_github = 'aminroosta';
var my_remote = 'amin';

const USAGE = `
****************************************************
** USAGE:
*
*         ~/checkout.js your-branch-name
** e.g:
*         ~/checkout.js amin/fix-poc-issue
*
** PREREQUISITE: 
*         export GITHUB_TOKEN='<your-personal-token-from-github>'
*
****************************************************
`
var child_process = require('child_process');

// ==> validate arguments
var branch = process.argv[2];
if(!branch) { console.warn("\x1b[31m" + USAGE); process.exit(1); }
if(!process.env.GITHUB_TOKEN) { console.warn("\x1b[31m" + USAGE, "\n GITHUB TOKEN IS MIISING.\n"); process.exit(2); }

// ==> run a blocking command in temrinal
var run = (command, options) => {
    var quiet = options && options.quiet;
    quiet || console.log(command);
    var res = child_process.execSync(command).toString();
    quiet || console.log(res);
    return res; 
}

// ==> run a non-blocking command in terminal
var runAsync = (command, options) => new Promise((resolve, reject) => {
  var quiet = options && options.quiet;
  console.log(command);
  child_process.exec(command, (error, stdout, stderr) => {
    if (error) {
        console.error("\x1b[31m===================>\n\n", error.message);
        process.exit(0)
        // return reject(error);
    }
    var res = stdout;
    quiet || console.log(res);
    resolve(res);
  });
});

// ==> get the list of all repositories
var repositories = run('cd /home/git/regentmarkets && ls -d */', {quiet: true})
    .split(/\s+/)
    .map(d => d.replace('/', '')) 
    .filter(d => d);

// checkout master
run(
  `cd /home/git/regentmarkets/ && \
   for d in $(ls -d * | sed 's/\/$//'); do cd /home/git/regentmarkets/$d && git stash && git checkout master; done`
  , {quiet: true}
);

// ==> add "my_remote" as a git remote if it doesn't exist
var add_remote = (repo) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  git config remote.${my_remote}.url >&- || git remote add ${my_remote} git@github.com:${my_github}/${repo}.git && \
  git fetch ${my_remote} && git fetch origin`, {quiet: true}
);

// ==> returns the "git diff", if the diff is empty it will be marked as a dummy pr
var diff_branch = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && \
    git diff ${my_remote}/${branch} origin/master --stat`, {quiet: true})
);

// ==> adds the branch if it doesn't already exist
var add_branch = (repo, branch) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  git rev-parse --verify --quiet ${my_remote}/${branch} || \
  git rev-parse --verify --quiet ${branch} || \
  git checkout -b ${branch} origin/master`, {quiet: true}
);

// ==> checkout an existing branch
var checkout_branch = (repo, branch) => runAsync(
  `cd /home/git/regentmarkets/${repo} && git checkout ${branch}`, {quiet: false}
);

// ==> list of all the pull requests found
var prs_found = [];

// ==> finds a pr matching the branch and the repo (or returnes undefined).
var find_pr = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && hub pr list -h ${my_github}:${branch}`, {quiet: true})
    .then(res => res.split(/\s+|#/)[2])
    .then(pr => pr && `https://github.com/regentmarkets/${repo}/pull/${pr}`)
    .then(pr => pr && add_remote(repo).then(() => pr))
    .then(pr => pr && repo)
);

// ==> then find prs from all repositories
Promise.all(
    repositories.map(
        repo => find_pr(repo, branch)
    )
)
.then(repos => repos.filter(repo => repo))
.then((repos) => Promise.all(
    repos.map((repo) => 
        add_branch(repo, branch)
        .then(() => checkout_branch(repo, branch))
        .then(() => `${repo} => ${branch}`)
    )
))
.then(rows => {
    console.log('\x1b[32m---\n');
    console.log(rows.join('\n'));
})['catch'](e => console.error(e));


