shared_context "registration" do
  include_context "user registration"
  background { visit register_path }
  given(:sign_up_heading)                { t('users.new.register') }
  given(:sign_up_page_title)             { full_title(t('users.new.register')) }
  given(:create_account)         { t('users.registration_form.create_account') }
  given(:clicking_create_account_button) { -> { click_button create_account } }
  given(:sign_out)                       { t('layouts.header.sign_out') }
  given(:successful_registration)        { t('flash.successful_registration') }
end