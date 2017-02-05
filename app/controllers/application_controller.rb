class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return unless session[:admin_id]
    Admin.find(session[:admin_id])
  end

  def authorize_admin
    redirect_to sign_in_path if !session[:admin_id].present?
  end
end
