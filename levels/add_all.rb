difficulty 1
description "There are some files in your folder that we want to add to the staging area. You should be able to do it with a single command"

FILES = ["README", "database.yml", "config.rb", "program.rb"]

setup do
  repo.init
  FILES.each { |f| FileUtils.touch f }
end

solution do
  FILES.each do |f|
    return false unless repo.status.files.keys.include?(f)
    return false if repo.status.files[f].untracked
  end
  true
end

hint do
  puts "When running `git add` when can give it eiter a file or a whole directory (like the current directory)."
end
