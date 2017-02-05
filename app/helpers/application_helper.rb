module ApplicationHelper
  def current_user
    Admin.find(session[:admin_id])
  end
end
