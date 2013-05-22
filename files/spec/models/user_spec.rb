require 'spec_helper'

describe User do

  let(:user) { create(:user) }

  specify "model attributes" do
    expect(user).to respond_to(:name, :email, :password_digest,
                               :authentication_token, :admin)
  end

  specify "virtual attributes/methods from has_secure_password" do
    expect(user).to respond_to(:password, :password_confirmation, :authenticate)
  end

  specify "initial state" do
    expect(user).to be_valid
    expect(user).to_not be_admin
    expect(user.authentication_token).to_not be_blank
  end

  describe "validations" do
    specify "for name" do
      expect(user).to validate_presence_of(:name)
      expect(user).to_not allow_value(" ").for(:name)
      expect(user).to ensure_length_of(:name).is_at_most(50)
    end

    specify "for email" do
      expect(user).to validate_presence_of(:email)
      expect(user).to_not allow_value(" ").for(:email)
      expect(user).to validate_uniqueness_of(:email).case_insensitive
      invalid_email_addresses.each do |invalid_address|
        expect(user).to_not allow_value(invalid_address).for(:email)
      end
      valid_email_addresses.each do |valid_address|
        expect(user).to allow_value(valid_address).for(:email)
      end
    end

    specify "for password" do
      # validation of presence and confirmation of password
      # done in has_secure_password
      expect(user).to ensure_length_of(:password).is_at_least(6)
      expect(user).to_not allow_value("mismatch").for(:password_confirmation)
    end
  end

  describe "#authenticate from has_secure_password" do
    let(:found_user) { User.find_by_email(user.email) }
    let(:successfully_authenticated_user) do
      found_user.authenticate(user.password)
    end
    let(:unsuccessfully_authenticated_user) do
      found_user.authenticate("invalid")
    end

    specify "with valid password" do
      expect(user).to eq(successfully_authenticated_user)
    end

    specify "with invalid password" do
      expect(user).to_not eq(unsuccessfully_authenticated_user)
      expect(unsuccessfully_authenticated_user).to be_false
    end
  end
end