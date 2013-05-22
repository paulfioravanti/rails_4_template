module Authenticatable

  def self.included(base)
    base.send :helper_method, :sign_in, :signed_in?,
              :sign_out, :current_user, :current_user=
  end

  private

    # A cookie that does not have an expiry will automatically be expired by
    # the browser when browser's session is finished.
    # cookies.permanent sets the expiry to 20 years
    # Booleans seem to get passed from forms as strings
    def sign_in(user)
      if remember_me
        cookies.permanent[:authentication_token] = user.authentication_token
      else
        cookies[:authentication_token] = user.authentication_token
      end
      self.current_user = user
    end

    def signed_in?
      !current_user.nil?
    end

    def sign_out
      self.current_user = nil
      cookies.delete(:authentication_token)
    end

    def current_user
      @current_user ||=
        User.find_by_authentication_token(cookies[:authentication_token])
    end

    def current_user=(user)
      @current_user = user
    end

    # Deal with remember me from sessions#new and users#new
    def remember_me
      params[:session].try(:[], :remember_me) == "true" ||
        params[:remember_me] == "true"
    end

    def deny
      redirect_to root_url, alert: t('.not_authorized') if signed_in?
    end
end