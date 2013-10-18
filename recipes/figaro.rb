def create_secure_app_config
  comment "# Get a new secret token to put in Figaro application config;"
  comment "# will be used in production."
  @secret_key = secret_key_base
  copy_from_repo 'config/application.yml', erb: true
end

def create_example_app_config
  comment "# Create example application config to check into source control"
  copy_from_repo 'config/application.example.yml'
end