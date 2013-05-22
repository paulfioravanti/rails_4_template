def generate_model_migrations
  comment "# Create users migration"
  generate "migration", "create_users"
end

def replace_migration_content
  comment "# Replace users migration content"
  user_migration_number = Dir['db/migrate/*_create_users.rb'].first.gsub(%r([^\d]), '')
  get "#{repo_root}/files/db/migrate/create_users.rb",
      "db/migrate/#{user_migration_number}_create_users.rb", force: true
end

def create_model_classes
  comment "# Create User class"
  copy_from_repo 'app/models/user.rb'
end