difficulty 3
description "You have made changes to your local master branch and want to publish those changes to the origin remote"

setup do
  # remember the working directory so we can come back to it later
  cwd = Dir.pwd
  # initialize another git repo to be used as a "remote"
  tmpdir = Dir.mktmpdir

  # local repo
  repo.init

  FileUtils.touch "file1"
  repo.add        "file1"
  repo.commit_all "First commit"

  FileUtils.touch "file2"
  repo.add        "file2"
  repo.commit_all "Second commit"

  # copy the repo to remote
  FileUtils.cp_r ".", tmpdir
  # add another file
  FileUtils.touch "file3"
  repo.add        "file3"
  repo.commit_all "Third commit"

  # remote repo
  Dir.chdir tmpdir
  repo.init
  # make a 'non-bare' repo accept pushes
  `git config receive.denyCurrentBranch ignore`

  # change back to original repo to set up a remote
  Dir.chdir cwd
  `git remote add origin #{tmpdir}/.git`
  `git fetch origin`
  `git branch -u origin/master master 2> /dev/null`
end

solution do
  repo.init
  result = true

  # Check the commits of the local branch and the branch are the same.
  local_commits = repo.commits("master")
  remote_commits = repo.commits("origin/master")
  result = false unless local_commits.size == 3
  local_commits.each_with_index do |commit, idx|
    result &&= (commit.id == remote_commits[idx].id)
  end

  result
end

hint do
  puts "Take a look at `git fetch`, `git pull`, and `git push`."
end
