class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      path = cookies[:return_to] || test_path
      redirect_to path
    else
      flash.now[:alert] = 'Wrong login or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    cookies[:return_to] = nil
    redirect_to login_path
  end
end
