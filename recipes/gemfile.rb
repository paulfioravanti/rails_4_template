def create_gem_file
  remove_file 'Gemfile'
  copy_from_repo 'Gemfile'
end