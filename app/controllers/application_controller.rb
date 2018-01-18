class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def rescue_with_record_not_found
    render plain: 'Record was not found'
  end

  private

  def authenticate_user!
    cookies[:return_to] = request.url
    redirect_to login_path, alert: 'Please, verify yourself' unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
