class UsersController < ApplicationController
  before_action :authorize_admin

  def index
    @users = User.where(company_id: current_user.company.id)
  end

  def create
    begin
      @user = User.new(
        firstname: params[:firstname],
        lastname: params[:lastname],
        username: params[:username],
        email: params[:email],
        company_id: params[:company_id],
        is_first_login: params[:is_first_login]
      )
      respond_to do |format|
        if @user.save
          format.json { render json: @user.to_json(include: [:company]) }
          Rails.logger.info "User has been created."
        else
          format.json { render json: @user.errors.full_messages.first, status: :unprocessable_entity }
        end
      end
    rescue => error
      Rails.logger.error error
    end
  end
end