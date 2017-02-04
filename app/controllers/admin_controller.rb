class AdminController < ApplicationController

  def create
    begin
      @admin = Admin.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password]
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
      # Rails.logger.error error
      # respond_to do |format|
      #   format.html { redirect_to licence_report_path }
      #   format.json { render json: error.message, status: :unprocessable_entity }
      # end
    end
  end
end