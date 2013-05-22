class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:session][:email],
                                params[:session][:password])
      sign_in user
      flash[:success] = t('flash.successful_sign_in')
      redirect_to root_url
    else
      flash.now[:error] = t('flash.invalid_credentials')
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = t('flash.successful_sign_out')
    redirect_to root_url
  end
end