#!/usr/bin/node
const execSync = require('child_process').execSync;

const run = (command) => {
    console.log(command);
    const res = execSync(command).toString();
    console.log(res);
    return res;
}

const github_name = 'aminroosta';

const branch = process.argv[2];
const message  = process.argv[3] || process.argv[2];
if(!branch) { console.warn('USAGE dummy-pr prefix/branch-name'); process.exit(1); }
const prefix = branch.split('/')[0];
if(!prefix) { console.warn('USAGE dummy-pr prefix/branch-name'); process.exit(1); }

const remotes = run('git remote -v | grep -v ^backup');
const upstream = remotes.split(/\s/)[1].replace(/(git@github.com:)(.*)(\/.*.git)/, `$1${github_name}$3`);

(remotes.indexOf(upstream) == -1) && run(`git remote add ${prefix} ${upstream}`);
run(`git fetch ${prefix} && git fetch origin`);

const branches = run('git branch') + '\n' + run ('git branch -r');
if(branches.indexOf(branch) == -1) run(`git checkout -b ${branch} origin/master`);
else run(`git checkout ${branch}`);

run('git config --global push.default simple');
run(`git commit --allow-empty -m '${message}'`);
run(`git push -u ${prefix} ${branch}`);

// https://github.com/regentmarkets/bom-pricing/compare/master...aminroosta:amin/inconsistent-error-for-tick-expiry-contracts

const origin = run('git remote -v | grep ^origin').split(/\s/)[1].replace(/(git@github.com:)(.*)(.git)/, "$2");
const url = `https://github.com/${origin}/compare/master...${github_name}:${branch}?title=${branch}`

console.warn("\x1b[32m===================>\n", url, "\n\n");
