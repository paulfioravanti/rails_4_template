shared_context "layout links" do
  include_context "user sign in"
  background { visit root_path }
  given(:logo)              { t('layouts.header.<%= app_name %>') }
  given(:home)              { t('layouts.header.home') }
  given(:home_page)         { root_path }
  given(:sign_in)           { t('sessions.new.sign_in') }
  given(:sign_in_page)      { signin_path }
  given(:register)          { t('layouts.header.register') }
  given(:registration_page) { register_path }
  given(:sign_out)          { t('layouts.header.sign_out') }
  given(:user_sign_out)     { signout_path }
end