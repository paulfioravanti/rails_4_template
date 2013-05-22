require 'spec_helper'

feature "User registration" do
  include_context "registration"

  scenario "viewing the registration page" do
    expect(page).to have_selector('h1', text: sign_up_heading)
    expect(page).to have_title sign_up_page_title
  end

  scenario "attempting to sign up with invalid information" do
    expect(clicking_create_account_button).to_not change(User, :count)
    expect(page).to have_title sign_up_page_title
    expect(page).to have_alert_message 'error'
    expect(page).to_not have_link sign_out
  end

  scenario "signing up with valid information" do
    register_a_user
    expect(clicking_create_account_button).to change(User, :count)
    expect(page).to have_alert_message('success', successful_registration)
    expect(page).to have_link sign_out
  end
end