require 'spec_helper'

feature "Layout links" do
  include_context "layout links"

  scenario "confirming visible links when not signed in" do
    expect(page).to have_link(logo, href: home_page)
    expect(page).to have_link(home, href: home_page)
    expect(page).to have_link(sign_in, href: sign_in_page)
    expect(page).to have_link(register, href: registration_page)
    expect(page).to_not have_link sign_out
  end

  scenario "confirming visible links when signed in" do
    sign_in_a_user
    expect(page).to have_link(logo, href: home_page)
    expect(page).to have_link(home, href: home_page)
    expect(page).to have_link(sign_out, href: user_sign_out)
    expect(page).to_not have_link sign_in
    expect(page).to_not have_link register
  end
end