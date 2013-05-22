def create_git_ignore_file
  comment "# Append custom content to .gitignore"
  remove_file '.gitignore'
  copy_from_repo '.gitignore'
end

def create_git_repo
  comment "# Create Git repo"
  git :init
end

def prevent_whitespaced_commits
  comment "# Stop commit of extraneous white space in git repo"
  run 'mv .git/hooks/pre-commit.sample .git/hooks/pre-commit'
end

def add_and_commit_to_repo
  comment "# Add and commit to repo"
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end