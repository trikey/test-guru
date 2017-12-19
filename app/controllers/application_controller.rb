class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def rescue_with_record_not_found
    render plain: 'Record was not found'
  end
end
