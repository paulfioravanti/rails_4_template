shared_context "home page" do
  include_context "user sign in"
  background { visit root_path }
  given(:signed_in_heading)     { t('pages.home_signed_in.heading') }
  given(:not_signed_in_heading) { "Welcome to the <%= app_name.titleize %>!" }
end