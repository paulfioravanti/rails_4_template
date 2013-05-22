def customize_application_css
  comment "# Change application.css into scss document"
  run "mv app/assets/stylesheets/application.css "\
      "app/assets/stylesheets/application.css.scss"

  comment "# Substitute out require_tree in favour of manual ordered requiring"
  comment "# of CSS files in application.css.scss"
  gsub_file 'app/assets/stylesheets/application.css.scss',
            %r(\s\*\= require_tree \.\n), ''
  comment "# Add reference to Bootstrap and overrides CSS file in application.css.scss"
  append_to_file 'app/assets/stylesheets/application.css.scss',
                 "@import \"bootstrap_and_overrides.css.scss\";"
end

def create_custom_css
  comment "# Create Bootstrap and overrides CSS file"
  copy_from_repo 'app/assets/stylesheets/bootstrap_and_overrides.css.scss'

  comment "# Create CSS file scss variables and mixins"
  copy_from_repo 'app/assets/stylesheets/variables_and_mixins.css.scss'

  comment "# Create CSS file for header"
  copy_from_repo 'app/assets/stylesheets/header.css.scss'

  comment "# Create CSS file for footer"
  copy_from_repo 'app/assets/stylesheets/footer.css.scss'
end