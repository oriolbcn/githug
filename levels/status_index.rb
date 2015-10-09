difficulty 1
description "We have added a file to the staging area (or index), but it's not commited yet. Which file is it?"

setup do
  repo.init
  %w{config.rb README setup.rb deploy.rb Guardfile}.each do |file|
    FileUtils.touch(file)
  end
  repo.add("setup.rb")
end

solution do

  name = request("What is the full file name of the file in the staging area?")

  if name != "setup.rb"
    return false
  end

  true
end

hint do
  puts "You are looking for a command to identify the status of the repository."
end
