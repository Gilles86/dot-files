#!/usr/bin/node
var my_github = 'aminroosta';
var my_remote = 'amin';

const USAGE = `
****************************************************
** USAGE:
*
*         ~/dummy-pr.js repo-name your-branch-name
** e.g:
*         ~/dummy-pr.js bom-rpc amin/fix-poc-issue
*
** PREREQUISITE: 
*         export GITHUB_TOKEN='<your-personal-token-from-github>'
*
****************************************************
`
var child_process = require('child_process');

var repository   = process.argv[2];
var branch = process.argv[3];
if(!branch) { console.warn(USAGE); process.exit(1); }
repository = repository && repository.replace('/', '');

var run = (command, options) => {
    var quiet = options && options.quiet;
    quiet || console.log(command);
    var res = child_process.execSync(command).toString();
    quiet || console.log(res);
    return res;
}

var runAsync = (command, options) => new Promise((resolve, reject) => {
  var quiet = options && options.quiet;
  console.log(command);
  child_process.exec(command, (error, stdout, stderr) => {
    if (error) {
        console.error(error.message);
        process.exit(0)
        // return reject(error);
    }
    var res = stdout;
    quiet || console.log(res);
    resolve(res);
  });
});

var repositories = run('cd /home/git/regentmarkets && ls -d */', {quiet: true})
    .split(/\s+/)
    .map(d => d.replace('/', ''))
    .filter(d => d);

// git config sets a return code when you ask for a nonexistent config.
var add_remote = (repo) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && \
    git config remote.${my_remote}.url >&- || git remote add ${my_remote} git@github.com:${my_github}/${repo}.git && \
    git fetch ${my_remote} && git fetch origin
  `, {quiet: true})
);

var diff_branch = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && \
    git diff ${my_remote}/${branch} origin/master --stat
  `, {quiet: true})
);

var add_branch = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && \
    git rev-parse --verify --quiet ${my_remote}/${branch} || git checkout -b ${branch} origin/master
  `, {quiet: true})
);

var find_pr_async = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && hub pr list -h ${my_github}:${branch}`, {quiet: true})
    .then(res => res.split(/\s+|#/)[2])
    .then(pr => pr && `https://github.com/regentmarkets/${repo}/pull/${pr}`)
    .then(pr => pr && add_remote(repo).then(() => pr))
    .then(pr => pr && diff_branch(repo, branch).then(diff => `${pr} ${diff ? 'change' : 'test'}`))
);


Promise.all(
    repositories.map(
        repo => find_pr_async(repo, branch)
    )
).then(prs => prs.filter(pr => pr))
.then(prs => runAsync(`echo '#BEGIN\n${prs.join('\n')}\n#END' > /tmp/prs.txt`))
.then(() => add_remote(repository))
.then(() => add_branch(repository, branch))
.then(() => runAsync(
    `cd /home/git/regentmarkets/${repository} && \
    git checkout ${branch} && git pull && \
    git commit --allow-empty -m '${branch}' && \
    git fetch -f ${my_remote} "refs/notes/pr:refs/notes/pr" && \
    git notes --ref=pr add -f -F /tmp/prs.txt HEAD && \
    git push -f ${my_remote} refs/notes/pr && \
    git push -u ${my_remote} ${branch}
    `
))
.then(() => find_pr_async(repository, branch))
.then(pr => console.log("\x1b[32m===================>\n", pr, "\n\n"));


