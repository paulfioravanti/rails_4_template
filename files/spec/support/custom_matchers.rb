module CustomMatchers
  extend RSpec::Matchers::DSL

  matcher :have_alert_message do |type, message|
    match do |page|
      page.has_selector?("div.alert.alert-#{type}", text: message)
    end
  end
end