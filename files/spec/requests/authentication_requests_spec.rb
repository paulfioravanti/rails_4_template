require 'spec_helper'

describe "Authentication Requests" do
  include_context "user sign in request"

  let(:user) { create(:user) }

  context "for signed-in users" do
    before { sign_in_via_request(user) }

    it "redirects on GET Users#new" do
      get register_path
      expect(response).to redirect_to(root_url)
    end

    it "redirects on POST Users#create" do
      post users_path
      expect(response).to redirect_to(root_url)
    end
  end

  describe "cookies" do
    specify "cookie expires in 20 years" do
      sign_in_via_request
      expect(response.headers["Set-Cookie"]).to \
        match %r(.+expires.+#{20.years.from_now.year})
    end

    specify "cookie expires as soon as the session finishes" do
      sign_in_via_request(remember_me: "false")
      expect(response.headers["Set-Cookie"]).to_not match(%r(expires))
    end
  end
end