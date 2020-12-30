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

var branch = process.argv[2];
var target_repos   = process.argv.slice(3);
if(!branch || !target_repos.length) { console.warn(USAGE); process.exit(1); }

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
        console.error("\x1b[31m===================>\n\n", error.message);
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
var add_remote = (repo) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  git config remote.${my_remote}.url >&- || git remote add ${my_remote} git@github.com:${my_github}/${repo}.git && \
  git fetch ${my_remote} && git fetch origin`, {quiet: true}
);

var diff_branch = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && \
    git diff ${my_remote}/${branch} origin/master --stat`, {quiet: true})
);

var add_branch = (repo, branch) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  git rev-parse --verify --quiet ${my_remote}/${branch} || \
  git rev-parse --verify --quiet ${branch} || \
  git checkout -b ${branch} origin/master`, {quiet: true}
);

var prs_found = [];

var find_pr = (repo, branch) => (
  runAsync(`cd /home/git/regentmarkets/${repo} && hub pr list -h ${my_github}:${branch}`, {quiet: true})
    .then(res => res.split(/\s+|#/)[2])
    .then(pr => pr && `https://github.com/regentmarkets/${repo}/pull/${pr}`)
    .then(pr => pr && add_remote(repo).then(() => pr))
    .then(pr => pr && diff_branch(repo, branch).then(diff => `${pr} ${diff ? 'change' : 'test'}`))
    .then(pr => {
        pr && prs_found.indexOf(pr) == -1 && prs_found.push(pr);
        return pr;
    })
);

var create_pr_file = (branch) => (
    Promise.all(
        repositories.map(
            repo => find_pr(repo, branch)
        )
    ).then(prs => prs.filter(pr => pr))
    .then(prs => runAsync(`echo '#BEGIN\n${prs.join('\n')}\n#END' > /tmp/prs.txt`))
);

var create_pr = (repo, branch) => runAsync(
  `cd /home/git/regentmarkets/${repo} && \
  git checkout ${branch} && git pull ${my_remote} ${branch} && \
  git commit --allow-empty -m '${branch}' && \
  git fetch -f ${my_remote} "refs/notes/pr:refs/notes/pr" && \
  git notes --ref=pr add -f -F /tmp/prs.txt HEAD && \
  git push -f ${my_remote} refs/notes/pr && \
  git push -u ${my_remote} ${branch} &&\
  hub pull-request -m '${branch}' >& /dev/null || echo "Updated PR on ${repo}:${branch}"`
);

create_pr_file(branch)
  .then(() => Promise.all(
     target_repos.map(repo => add_remote(repo)
         .then(() => add_branch(repo, branch))
         .then(() => create_pr(repo, branch))
         .then(() => find_pr(repo, branch))
     )
  ))
  .then(() => {
      var change_prs = prs_found.filter(pr => pr.endsWith('change')).map(pr => '- ' + pr.split(' ')[0]);
      var test_prs = prs_found.filter(pr => pr.endsWith('test')).map(pr => '- ' + pr.split(' ')[0]);
      var environment = change_prs.length &&
          change_prs.map(pr => {
              var repo = pr.split('/')[4];
              return `${repo}:\n  - ${my_github}/${repo}\n  - ${branch}`;
          }).join('\n');

      change_prs.length && console.log(
          '\x1b[32m---\n',
          '\n# PRs to be merged:\n' + change_prs.join('\n')
      );
      change_prs.length && console.log(
          '\n# Dummy PRs:\n' + test_prs.join('\n')
      );
      environment && console.log( '\n# environment.yml\n```\n' + environment + '\n```\n');

  })['catch'](e => console.error(e));


