def git_current_branch [] {
  ^git rev-parse --abbrev-ref HEAD
}

def git_main_branch [] {
  let sources = ["heads", "remotes/origin", "remotes/upstream"]
  let names = ["main", "master", "trunk", "default", "stable", "mainline"]

  for source in $sources {
    for name in $names {
      let ref = $"refs/($source)/($name)"
      if (^git show-ref --verify --quiet $ref | complete).exit_code == 0 {
        return $name
      }
    }
  }

  return "main"
}

def git_develop_branch [] {
  let branches = ["dev", "devel", "development", "develop", "next", "unstable"]
  for branch in $branches {
    let ref = $"refs/heads/($branch)"
    if (^git show-ref --verify --quiet $ref | complete).exit_code == 0 {
      return $branch
    }
  }

  return "develop"
}

def git_feature_branch [] {
  if (^git show-ref | str contains '/feat/') {
    return "feat"
  }

  return "feature"
}

# g: git
export alias g = git

# ga: git add
export alias ga = git add
export alias gaa = git add --all
export alias gapa = git add --patch
export alias gau = git add --update
export alias gav = git add --verbose
export alias gap = git apply
export alias gapt = git apply --3way

# gb: git branch
export alias gb = git branch
export alias gba = git branch -a
export alias gbd = git branch -d
export alias gbdf = git branch -d -f
export alias gbD = git branch -D
export alias gbDf = git branch -D -f
export alias gbnm = git branch --no-merged
export alias gbr = git branch --remote

# gbl: git blame
export alias gbl = git blame -b -w

# gbs: git bisect
export alias gbs = git bisect
export alias gbsb = git bisect bad
export alias gbsg = git bisect good
export alias gbsr = git bisect reset
export alias gbss = git bisect start

# gc: git commit
export alias gc = git commit -v
export alias gci = git commit --allow-empty -v -m 'chore: initial commit'
export alias gc! = git commit -v --amend
export alias gcn = git commit -v --no-edit
export alias gcn! = git commit -v --amend --no-edit
export alias gca = git commit -a -v
export alias gca! = git commit -a -v --amend
export alias gcan! = git commit -a -v --no-edit --amend
export alias gcans! = git commit -a -v -s --no-edit --amend
export alias gcam = git commit -a -m
export alias gcas = git commit -a -s
export alias gcasm = git commit -a -s -m
export alias gcsm = git commit -s -m
export alias gcm = git commit -m
export alias gcs = git commit -S

# gcf: git config
export alias gcf = git config --list

# gcl: git clone
export alias gcl = git clone
export alias gcld = git clone --depth=1
export alias gclr = git clone --recurse-submodules

# gclean: git clean
export alias gclean = git clean -id

# gco: git checkout
export alias gco = git checkout
export alias gcob = git checkout -b
export alias gcom = git checkout (git_main_branch)
export alias gcod = git checkout (git_develop_branch)
export alias gcof = git checkout (git_feature_branch_prepend) ++ "/"
export alias gcoh = git checkout hotfix/
export alias gcor = git checkout release/
export alias gcos = git checkout support/
export alias gcors = git checkout --recurse-submodules

# gcount: git count
export alias gcount = git shortlog -sn

# gcp: git cherry-pick
export alias gcp = git cherry-pick
export alias gcpa = git cherry-pick --abort
export alias gcpc = git cherry-pick --continue

# gd: git diff
export alias gd = git diff
export alias gdca = git diff --cached
export alias gdcw = git diff --cached --word-diff
export alias gdct = git diff --staged
export alias gdt = git diff-tree --no-commit-id --name-only -r
export alias gdup = git diff @{upstream}
export alias gdct = git describe --tags (git rev-list --tags --max-count=1)

# gf: git fetch
export alias gf = git fetch
export alias gfa = git fetch --all --prune
export alias gfo = git fetch origin

# gh: git help
export alias ghh = git help

# gi: git init
export alias gi = git init

# gignore: git ignore
export alias gignore = git update-index --assume-unchanged
export alias gignored = git ls-files -v | lines | where {|it| $it =~ '^[a-z]'}

# gk: gitk
export alias gk = gitk --all --branches
export alias gke = gitk --all (git log -g --pretty=%h)

# alias gfg = git ls-files | grep

# gl: git log
export alias gl = git log
export alias gls = git log --stat
export alias glsp = git log --stat -p
export alias glg = git log --graph
export alias glgda = git log --graph --decorate --all
export alias glgm = git log --graph --max-count=10
export alias glo = git log --oneline --decorate
export alias glog = git log --oneline --decorate --graph
export alias gloga = git log --oneline --decorate --graph --all

# gm: git merge
export alias gm = git merge
export alias gms = git merge --squash
export alias gmom = git merge origin/(git_main_branch)
export alias gmum = git merge upstream/(git_main_branch)
export alias gma = git merge --abort

# gmtl: git mergetool
export alias gmtl = git mergetool --no-prompt
export alias gmtlvim = git mergetool --no-prompt --tool=vimdiff

# gp: git push
export alias gp = git push
export alias gpd = git push --dry-run
export alias gpf = git push --force-with-lease
export alias gpf! = git push --force
export alias gpsu = git push --set-upstream origin (git_current_branch)
export alias gpt = git push --tags
export alias gptf = git push --tags --force-with-lease
export alias gptf! = git push --tags --force
export def gpoat [] {
  git push origin --all; git push origin --tags
}
export def gpoatf! [] {
  git push origin --all --force; git push origin --tags --force 
}
export alias gpv = git push -v

# gpl: git pull
export alias gpl = git pull
export alias gplo = git pull origin
export alias gplom = git pull origin (git_main_branch)
export alias gplu = git pull upstream
export alias gplum = git pull upstream (git_main_branch)

# gr: git remote
export alias gr = git remote -v
export alias gra = git remote add
export alias grau = git remote add upstream
export alias grrm = git remote remove
export alias grmv = git remote rename
export alias grset = git remote set-url
export alias gru = git remote update
export alias grv = git remote -v
export alias grvv = git remote -vvv

# grb: git rebase
export alias grb = git rebase
export alias grba = git rebase --abort
export alias grbc = git rebase --continue
export alias grbd = git rebase (git_develop_branch)
export alias grbi = git rebase -i
export alias grbom = git rebase origin/(git_main_branch)
export alias grbo = git rebase --onto
export alias grbs = git rebase --skip

# grev: git revert
export alias grev = git revert

# grs: git reset
export alias grs = git reset
export alias grs! = git reset --hard
export alias grsh = git reset HEAD
export alias grsh! = git reset HEAD --hard
export alias grsoh = git reset origin/(git_current_branch)
export alias grsoh! = git reset origin/(git_current_branch) --hard
export def gpristine [] {
  git reset --hard; git clean -dffx
}
export alias grs- = git reset --

# grm: git remove
export alias grm = git rm
export alias grmc = git rm --cached

# grst: git restore
export alias grst = git restore
export alias grsts = git restore --source
export alias grstst = git restore --staged

# grt: git root
export alias grt = cd (git rev-parse --show-toplevel | default ".")

# gs: git status
export alias gs = git status
export alias gss = git status -s
export alias gsb = git status -sb

# gshow: git show
export alias gshow = git show
export alias gshowps = git show --pretty=short --show-signature

# gst: git stash
export alias gst = git stash
export alias gsta = git stash apply
export alias gstc = git stash clear
export alias gstd = git stash drop
export alias gstl = git stash list
export alias gstp = git stash pop
export alias gstshow = git stash show --text
export alias gstall = git stash --all
export alias gsts = git stash save

# gsu: git submodule update
export alias gsu = git submodule update

# gsw: git switch
export alias gsw = git switch
export alias gswc = git switch -c
export alias gswm = git switch (git_main_branch)
export alias gswd = git switch (git_develop_branch)

# gt: git tag
export alias gt = git tag
export alias gts = git tag -s
export alias gta = git tag -a
export alias gtas = git tag -a -s

# gwch: git whatchanged
export alias gwch = git whatchanged -p --abbrev-commit --pretty=medium

# gwt: git worktree
export alias gwt = git worktree
export alias gwta = git worktree add
export alias gwtls = git worktree list
export alias gwtmv = git worktree move
export alias gwtrm = git worktree remove

# gam: git am
export alias gam = git am
export alias gamc = git am --continue
export alias gams = git am --skip
export alias gama = git am --abort
export alias gamscp = git am --show-current-patch
