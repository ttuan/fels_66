class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "sessions.please_log_in"
      redirect_to login_url
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:danger] = t "admin.require_admin"
      redirect_to root_path
    end
  end
end
