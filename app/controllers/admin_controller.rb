class AdminController < ApplicationController

  def create
    begin
      @admin = Admin.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password],
        is_admin: true
      )
      respond_to do |format|
        if @admin.save
          format.html { redirect_to sign_up_report_path, notice: 'Admin has been created!' }
          format.json { render json: @admin.to_json() }
        else
          format.html { redirect_to sign_up_report_path }
          format.json { render json: @admin.errors.full_messages, status: :unprocessable_entity }
        end
      end
    rescue => error
      Rails.logger.error error
    end
  end

  def log_in
    @admin = Admin.find_by_email(params[:email])
    unless @admin.present?
      redirect_to '/sign_in', :danger => "Username or Password was wrong."
      # redirect_to '/sign_in'
    else
      admin_hash = BCrypt::Password.new(@admin.password)
      if @admin && admin_hash == params[:password] && @admin.is_admin
        session[:admin_id] = @admin.id
        redirect_to dashboard_path
      else
        redirect_to '/sign_in'
      end
    end
  end

  def log_out
    reset_session
    redirect_to '/sign_in'
  end
end