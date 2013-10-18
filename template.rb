## Before using this generator:
# $ rvm use 2.0.0

# Determine which template to use based on parameter given in generator
# rails new my_app -m <template>.  Supports github repo and local repo.
template_path = ARGV[2].dup
if template_path =~ %r(\Ahttps://raw.github.com)
  path = template_path.chomp("/template.rb")
else
  path = template_path.insert(0, "#{Dir.pwd}/../").chomp("/template.rb")
end

define_singleton_method :repo_root do
  path
end

def secret_key_base
  token = StringIO.new
  IO.popen("rake secret") do |pipe|
    pipe.each do |line|
      token.print(line.chomp)
    end
  end
  token.string
end

apply "#{repo_root}/utilities.rb"

heading "Define Gems" ##########################################################
apply recipe("gemfile")

create_gem_file

heading "Configure RVM" ########################################################
apply recipe("rvm")

update_rvm
create_rvm_bundler_integration
set_rvm_ruby_version

heading "Edit Environment Files" ###############################################
apply recipe("environment")

sub_heading "Application"

split_out_locale_files
add_custom_libraries_to_load_path
remove_test_unit_from_railties
suppress_helper_and_view_spec_generation

heading "Figaro Config" ########################################################
apply recipe("figaro")

create_secure_app_config
create_example_app_config

heading "Config/create Postgres Database" ######################################
apply recipe("database")

create_secure_database_config
destroy_any_previous_databases
create_databases

heading "Configure Initializers" ###############################################
apply recipe("initializers")

create_basic_initializers_for_installed_gems
insert_figaro_config_into_secret_token
simple_form_initializer

heading "Configure Locale Structure" ###########################################
apply recipe("locales")

create_rails_locales
create_app_locales
create_vendor_locales

heading "Create/overrride Bootstrap JS/CSS" ####################################

apply recipe("javascript")
require_custom_javascript

apply recipe("css")
customize_application_css
create_custom_css

heading "Create Base Models" ###################################################
apply recipe("models")

generate_model_migrations
replace_migration_content
migrate_databases
create_model_classes

seed_databases

heading "Customize Generated Views" ############################################
apply recipe("views")

customize_application_view
create_partials_for_layout

heading "Generate App Resources" ##############################################
apply recipe("app")

replace_routes
create_shared_resources
create_page_resources
create_session_resources
create_user_resources
create_shared_libraries

heading "App Clean Up" #########################################################

clean_up_generated_app_content
annotate_app

heading "Setup Testing Frameworks" #############################################
apply recipe("spec")

bootstrap_test_frameworks
configure_rspec
# customize_guard_file # Currently a development dependency issue with RSpec
configure_test_coverage

heading "Create initial basic specs" ###########################################

create_initial_specs
create_initial_factories

heading "Git-related config" ###################################################
apply recipe("git")

create_git_ignore_file
create_git_repo
prevent_whitespaced_commits

heading "Run tests, commit" ####################################################

run_tests
add_and_commit_to_repo