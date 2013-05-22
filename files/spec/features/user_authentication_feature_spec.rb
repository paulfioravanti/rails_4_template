require 'spec_helper'

feature "User authentication" do
  include_context "authentication"

  scenario "viewing the sign in page" do
    expect(page).to have_title sign_in_page_title
    expect(page).to have_selector('h1', text: sign_in_heading)
  end

  scenario "unsuccessful sign in attempt" do
    click_button sign_in
    expect(page).to have_title sign_in_page_title
    expect(page).to have_alert_message('error', invalid)
  end

  scenario "visiting another page after invalid sign in attempt" do
    click_button sign_in
    click_link home
    expect(page).to_not have_alert_message 'error'
  end

  scenario "successful sign in" do
    sign_in_a_user
    expect(page).to have_alert_message('success', successful_sign_in)
  end

  scenario "signed-in user signing out" do
    sign_in_a_user
    click_link sign_out
    expect(page).to have_alert_message('success', successful_sign_out)
  end
end