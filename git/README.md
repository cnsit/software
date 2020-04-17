# Git 常用命令
## 验证安装
- `git --version`
## 设置环境
- `git config --global user.name`
- `git config --global user.email`
## 初始化
- `mkdir {name}`
- `cd {name}`
- `git init`
- `git status`
## 新文件
- `git add {file}`
- `git add -A`
- `git commit -m {message}`
## Branch
- `git branch {name}`
- `git branch -t {name} {remote name}/{name}`
- `git checkout {name}`
## 远程
- `git remote add {name} {url}`
- `git remote -v`
- `git push {name} {branch}`
- `git pull {name} {branch}`
- `git pull {branch}` 对于使用 -t 创建的 branch
## 用远程内容覆盖本地工作目录
- `git fetch`
- `git reset --hard {remote name}/{remote branch}`
## 本地合并
- `git checkout {target branch}` 合并后的目标分支
- `git merge {source branch}` 合并的分支
- `git branch -d {source branch}` 删除合并的分支
- `git push {remote name} --delete {branch}` 同时删除远程的分支
## Rebase
- `git checkout {name}`
- `git rebase master {name}`
- `git rebase --onto master {name1} {name2} ...`