#!/usr/bin/node
var my_github = 'aminroosta';
var my_remote = 'amin';

const USAGE = `
****************************************************
** USAGE:
*
*         ~/dummy-pr.js your-branch-name repo-name-1 [repo-name-2 ...]
** e.g:
*         ~/dummy-pr.js amin/fix-poc-issue bom-rpc binary-websocket-api
*
** PREREQUISITE: 
*         export GITHUB_TOKEN='<your-personal-token-from-github>'
*
****************************************************
`
var child_process = require('child_process');

// ==> validate arguments
var branch = process.argv[2];
var target_repos   = process.argv.slice(3);
if(!branch || !target_repos.length) { console.warn("\x1b[31m" + USAGE); process.exit(1); }
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

// ==> list of all the pull requests found
var prs_found = [];

// ==> finds a pr matching the branch and the repo (or returnes undefined).
var find_pr = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && hub pr list -h ${my_github}:${branch}`, {quiet: true})
    .then(res => res.split(/\s+|#/)[2])
    .then(pr => pr && `https://github.com/regentmarkets/${repo}/pull/${pr}`)
    .then(pr => pr && add_remote(repo).then(() => pr))
    .then(pr => pr && diff_branch(repo, branch).then(diff => `${pr} ${diff ? 'to_merge' : 'dummy'}`))
    .then(pr => {
        pr && prs_found.indexOf(pr) == -1 && prs_found.push(pr);
        return pr;
    })
);

// ==> commits your local changes, anything already in the "git stash".
// ==> if there is no to_merge (dummy pr), it creates an empty commit.
var commit_changes = (repo, branch) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  git checkout ${branch} && git pull ${my_remote} ${branch} || echo "SKIPPED" && \
  git commit --allow-empty -m '${branch}' && \
  git push -u ${my_remote} ${branch}`
);

// ==> on first pass, we crete a pr without the notes.
var create_pr_without_notes = (repo, branch) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  hub pull-request -m '${branch}' >& /dev/null || echo "Updated PR on ${repo}:${branch}"`
);

// ==> on the second pass, we update the notes for the pr.
var update_pr_notes = (repo, branch) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  git fetch -f ${my_remote} "refs/notes/pr:refs/notes/pr" || echo "IGNORE" && \
  git notes --ref=pr add -f -F /tmp/prs.txt HEAD && \
  git push -f ${my_remote} refs/notes/pr && \
  hub pull-request -m '${branch}' >& /dev/null || echo "Updated PR on ${repo}:${branch}"`
);

// ==> add remote, branch, commit changes and create a pr without notes
var promise = Promise.all(
    target_repos.map(repo => add_remote(repo)
        .then(() => add_branch(repo, branch))
        .then(() => commit_changes(repo, branch))
        .then(() => create_pr_without_notes(repo, branch))
    )
)
// ==> then find prs from all repositories, including the ones we just created.
.then(() => Promise.all(
    repositories.map(
        repo => find_pr(repo, branch)
    ))
).then(prs => prs.filter(pr => pr))
// ==> write the git notes file.
 .then(prs => runAsync(`echo '#BEGIN\n${prs.join('\n')}\n#END' > /tmp/prs.txt`))
// ==> now update the prs, this time with the notes.
 .then(() => Promise.all(
     target_repos.map(repo => update_pr_notes(repo, branch))
  ))
// ==> pretty print the result, in a format we can copy to redmine tasks.
 .then(() => {
    function format_pr(pr) {
        // example output:
        // - ![circle-ci](https://circleci.com/gh/regentmarkets/binary-websocket-api/tree/pull%2F4031.svg) https://github.com/regentmarkets/bom/pull/1878 
        pr = pr.split(' ')[0];
        var parts = pr.split('/');
        return ['-', `![circle-ci](https://circleci.com/gh/${parts[3]}/${parts[4]}/tree/pull%2F${parts[6]}.svg)`, pr].join(' ');
    }
    var to_merge_prs = prs_found.filter(pr => pr.endsWith('to_merge')).map(format_pr);
    var dummy_prs = prs_found.filter(pr => pr.endsWith('dummy')).map(format_pr);

    var environment = to_merge_prs.length &&
        to_merge_prs.map(pr => {
            var repo = pr.split(' ')[2].split('/')[4];
            return `${repo}:\n  - ${my_github}/${repo}\n  - ${branch}`;
        }).join('\n');

    console.log('\x1b[32m---\n');
    to_merge_prs.length && console.log(
        '\n# PRs to be merged\n' + to_merge_prs.join('\n')
    );
    dummy_prs.length && console.log(
        '\n# Dummy PRs:\n' + dummy_prs.join('\n')
    );
    environment && console.log( '\n# environment.yml\n```\n' + environment + '\n```\n');
})['catch'](e => console.error(e));


