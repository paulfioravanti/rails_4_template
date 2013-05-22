shared_context "authentication" do
  include_context "user sign in"
  background { visit signin_path }
  given(:sign_in)             { t('sessions.new.sign_in') }
  given(:sign_in_page_title)  { t('sessions.new.sign_in') }
  given(:sign_in_heading)     { t('sessions.new.sign_in') }
  given(:sign_out)            { t('layouts.header.sign_out') }
  given(:invalid)             { t('flash.invalid_credentials') }
  given(:home)                { t('layouts.header.home') }
  given(:successful_sign_in)  { t('flash.successful_sign_in')}
  given(:successful_sign_out) { t('flash.successful_sign_out')}
end