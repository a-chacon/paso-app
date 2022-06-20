class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    unless @user.errors.empty?
      flash.now[:errors] = @user.errors
      render turbo_stream: turbo_stream.update('errors', partial: 'shared/errors')
      return
    end
    session[:user_id] = @user.id
    redirect_to '/home'
  end

  def update; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
