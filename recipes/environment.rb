def split_out_locale_files
  comment "# Add support for split out locale files under config/locales/*"
  application "config.i18n.load_path +=\n"\
    "      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]"
end

def add_custom_libraries_to_load_path
  comment "# Add custom libraries under lib/ to load path"
  application %Q(config.autoload_paths += Dir["\#{config.root}/lib/**/"])
end

def remove_test_unit_from_railties
  comment "# Replace rails/all with individual railties"
  comment "# except test::unit (using RSpec)"
  gsub_file 'config/application.rb', "require 'rails/all'" do <<-RUBY
# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"
RUBY
  end
end

def suppress_helper_and_view_spec_generation
  comment "# Don't generate helper or view specs"
  insert_into_file 'config/application.rb',
                   after: "Rails::Application\n" do <<-RUBY
    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.fixture_replacement :factory_girl
    end
  RUBY
  end
end

def no_asset_debug
  comment "# Change assets.debug to false due to GET assets error on "\
          "locale change"
  gsub_file 'config/environments/development.rb',
            'config.assets.debug = true',
            'config.assets.debug = false'
end