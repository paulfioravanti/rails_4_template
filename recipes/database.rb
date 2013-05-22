def create_secure_database_config
  comment "# Remove default sqlite config and replace with secure postgresql"
  remove_file 'config/database.yml'
  copy_from_repo 'config/database.yml'
end

def destroy_any_previous_databases
  comment "Drop any previous #{app_name} development databases"
  rake 'db:drop', env: 'development'

  comment "Drop any previous #{app_name} test databases"
  rake 'db:drop', env: 'test'
end

def create_databases
  comment "Create #{app_name} development database"
  rake 'db:create', env: 'development'

  comment "Create #{app_name} test database"
  rake 'db:create', env: 'test'
end

def migrate_databases
  comment "# Migrate development database"
  rake 'db:migrate', env: 'development'
  comment "# Migrate test database"
  rake 'db:migrate', env: 'test'
end

def seed_databases
  comment "# Seed development database with models"
  comment "# You can sign in with user credentials defined in db/seeds.rb"
  remove_file 'db/seeds.rb'
  copy_from_repo 'db/seeds.rb', erb: true
  rake 'db:seed', env: 'development'
end