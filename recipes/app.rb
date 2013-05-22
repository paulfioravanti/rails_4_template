def replace_routes
  comment "# Replace routes.rb with custom version"
  remove_file 'config/routes.rb'
  copy_from_repo 'config/routes.rb', erb: true
end

def create_shared_resources
  comment "# Replace application_controller.rb with custom version"
  remove_file 'app/controllers/application_controller.rb'
  copy_from_repo 'app/controllers/application_controller.rb'

  comment "# Replace application_helper.rb with custom version"
  remove_file 'app/helpers/application_helper.rb'
  copy_from_repo 'app/helpers/application_helper.rb'

  comment "# Create shared error messages partial"
  copy_from_repo 'app/views/shared/_error_messages.html.haml'
end

def create_page_resources
  comment "# Create pages controller"
  copy_from_repo 'app/controllers/pages_controller.rb'
  comment "# Create home view"
  copy_from_repo 'app/views/pages/home.html.haml'
  comment "# Create signed in home view"
  copy_from_repo 'app/views/pages/_home_signed_in.html.haml'
  comment "# Create not signed in home view"
  copy_from_repo 'app/views/pages/_home_not_signed_in.html.haml'
  comment "# Create home Markdown file"
  copy_from_repo 'config/locales/pages/home/home.en.md', erb: true
end

def create_session_resources
  comment "# Create sessions controller"
  copy_from_repo 'app/controllers/sessions_controller.rb'
  comment "# Create sign in view"
  copy_from_repo 'app/views/sessions/new.html.haml'
  comment "# Create sign in form"
  copy_from_repo 'app/views/sessions/_sign_in_form.html.haml'
end

def create_user_resources
  comment "# Create users controller"
  copy_from_repo 'app/controllers/users_controller.rb'
  comment "# Create register user view"
  copy_from_repo 'app/views/users/new.html.haml'
  comment "# Create registration form partial"
  copy_from_repo 'app/views/users/_registration_form.html.haml'
end

def create_shared_libraries
  comment "# Create Authenticatable module"
  copy_from_repo 'lib/authenticatable.rb'
end

def clean_up_generated_app_content
  comment "# Remove public/index.html to enable root path"
  remove_file 'public/index.html'

  comment "# Remove test directory as not needed for RSpec"
  run 'rm -rf test/'
end