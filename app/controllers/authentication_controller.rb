class AuthenticationController < ApplicationController
  before_action :verify_captcha, only: [:create]

  def new
    @user = User.new
    redirect_to '/home' if @current_user
  end

  def create
    if (user = User.authenticate(email: params[:email], password: params[:password]))
      session[:user_id] = user.id
      redirect_to '/home'
    else
      flash.now[:errors] = [OpenStruct.new(attribute: 'Email/Password', message: "don't match")]
      render turbo_stream: turbo_stream.update('errors', partial: 'shared/errors')
    end
  end

  def destroy
    session.delete(:user_id)
    # Clear the memoized current user
    @current_user = nil
    redirect_to root_url
  end
end
