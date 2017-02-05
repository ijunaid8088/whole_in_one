class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  helper_method :current_user

  def authorize_admin
    redirect_to sign_in_path if !session[:admin_id].present?
  end

  def logged_in
    redirect_to dashboard_path if session[:admin_id].present?
  end
end
