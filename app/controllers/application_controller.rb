class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def rescue_with_record_not_found
    render plain: 'Record was not found'
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_tests_path
    else
      stored_location_for(resource) || signed_in_root_path(resource)
    end
  end


end
