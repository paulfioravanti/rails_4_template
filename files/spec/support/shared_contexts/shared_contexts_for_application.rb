shared_context "user sign in" do
  def sign_in_a_user(user = nil, remember_me: "true")
    visit signin_path unless current_path == signin_path
    user ||= create(:user)
    activerecord_scope = 'activerecord.attributes.user'
    sessions_scope = 'sessions.sign_in_form'
    fill_in t(:email, scope: activerecord_scope),    with: user.email
    fill_in t(:password, scope: activerecord_scope), with: user.password
    if remember_me == "true"
      check t(:remember_me, scope: sessions_scope)
    else
      uncheck t(:remember_me, scope: sessions_scope)
    end
    click_button t(:sign_in, scope: sessions_scope)
    user
  end
end

shared_context "user sign in request" do
  def sign_in_via_request(user = nil, remember_me: "true")
    user ||= create(:user)
    post session_path(
      session: {
        email: user.email,
        password: user.password,
        remember_me: remember_me
      }
    )
  end
end

shared_context "user registration" do
  def register_a_user(user = nil, remember_me: "true")
    visit register_path unless current_path == register_path
    user ||= build(:user)
    activerecord_scope = 'activerecord.attributes.user'
    user_scope = 'users.registration_form'
    fill_in t(:name, scope: activerecord_scope), with: user.name
    fill_in t(:email, scope: activerecord_scope), with: user.email
    # Use custom labels for Password, Password confirmation
    # due to Capybara ambiguities error: a string can't be a substring of
    # another element otherwise it's considered ambiguous
    fill_in t(:password, scope: user_scope), with: user.password
    fill_in t(:password_confirmation, scope: user_scope), with: user.password
    if remember_me == "true"
      check t(:remember_me, scope: user_scope)
    else
      uncheck t(:remember_me, scope: user_scope)
    end
    User.find_by_email("#{user.email.downcase}")
  end
end