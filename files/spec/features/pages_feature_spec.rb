require 'spec_helper'

feature "Home page" do
  include_context "home page"

   scenario "when signed in" do
     sign_in_a_user
     expect(page).to have_selector('h1', signed_in_heading)
   end

   scenario "when not signed in" do
     expect(page).to have_selector('h1', not_signed_in_heading)
   end
end