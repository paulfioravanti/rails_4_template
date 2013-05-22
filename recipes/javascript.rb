def require_custom_javascript
  comment "# Require JS for JQuery, rails-timeago, i18n-js, bootstrap"
  insert_into_file 'app/assets/javascripts/application.js',
                   after: %r(require jquery_ujs\n) do <<-JAVASCRIPT
//= require bootstrap
JAVASCRIPT
  end
end