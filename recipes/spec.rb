def bootstrap_test_frameworks
  # comment "# Configure app for testing (RSpec with Spork and Guard)"
  comment "# Configure app for testing (RSpec with Spork)"
  comment "# Bootstrap RSpec"
  generate 'rspec:install'
  comment "# Bootstrap Spork"
  run 'spork --bootstrap'
  # Current development dependency issue with Guard, so don't use for now
  # comment "# Bootstrap Guard with Rspec and Spork"
  # run 'guard init rspec'
  # run 'guard init spork'
end

def configure_rspec
  comment "# Configure RSpec output to use Fuubar"
  append_to_file '.rspec', "--format Fuubar\n--drb"

  comment "# Replace generated spec_helper.rb with custom version"
  remove_file 'spec/spec_helper.rb'
  copy_from_repo 'spec/spec_helper.rb', erb: true
end

def customize_guard_file
  comment "# Edit generated default file so Guard doesn’t run all tests"
  comment "# after a failing test passes."
  gsub_file 'Guardfile',
            %r(guard 'rspec' do),
            "guard 'rspec', version: 2, all_after_pass: false, cli: '--drb' do"
  modernize_hash_syntax 'Guardfile'
end

def create_initial_specs
  comment "# Create home page routing spec"
  copy_from_repo 'spec/routing/routing_spec.rb'

  comment "# Create controller specs"
  copy_from_repo 'spec/controllers/application_controller_spec.rb'

  comment "# Create helper specs"
  copy_from_repo 'spec/helpers/application_helper_spec.rb'

  comment "# Create feature specs"
  copy_from_repo 'spec/features/layout_feature_spec.rb'
  copy_from_repo 'spec/features/pages_feature_spec.rb', erb: true
  copy_from_repo 'spec/features/user_authentication_feature_spec.rb'
  copy_from_repo 'spec/features/user_registration_feature_spec.rb'

  comment "# Create request specs"
  copy_from_repo 'spec/requests/authentication_requests_spec.rb'

  comment "# Create model specs"
  copy_from_repo 'spec/models/user_spec.rb'

  comment "# Create spec utilities"
  copy_from_repo 'spec/support/utilities.rb'
  copy_from_repo 'spec/support/custom_matchers.rb'

  comment "# Create shared contexts"
  copy_from_repo "spec/support/shared_contexts/"\
                 "shared_contexts_for_application.rb"
  copy_from_repo 'spec/support/shared_contexts/shared_contexts_for_layout.rb',
                 erb: true
  copy_from_repo 'spec/support/shared_contexts/shared_contexts_for_pages.rb',
                 erb: true
  copy_from_repo "spec/support/shared_contexts/"\
                 "shared_contexts_for_user_authentication.rb"
  copy_from_repo "spec/support/shared_contexts/"\
                 "shared_contexts_for_user_registration.rb"
end

def create_initial_factories
  comment "# Create users factory"
  copy_from_repo 'spec/factories/user_factories.rb'
end

def run_tests
  comment "# Run tests"
  run 'rspec spec/'
end

def configure_test_coverage
  comment "# Configure test coverage files"
  copy_from_repo '.simplecov'
  copy_from_repo '.coveralls.yml'
end