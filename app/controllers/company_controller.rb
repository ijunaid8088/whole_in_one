class CompanyController < ApplicationController

  def index
    @companies =  Company.where(admin_id: current_user.id)
  end

  def create
    begin
      @company = Company.new(
        company_name: params[:company_name],
        namespace: params[:namespace],
        admin_id: params[:admin_id]
      )
      respond_to do |format|
        if @company.save
          format.json { render json: @company.to_json(include: [:admin]) }
          Rails.logger.info "Company has been created."
        else
          format.json { render json: @company.errors.full_messages.first, status: :unprocessable_entity }
        end
      end
    rescue => error
      Rails.logger.error error
    end
  end

  def delete
    begin
      @company = Company.find(params[:company_id])
      respond_to do |format|
        if @company.destroy
          format.json { render json: "1" }
          Rails.logger.info "Company has been deleted."
        else
          format.json { render json: @company.errors.full_messages.first, status: :unprocessable_entity }
        end
      end
    rescue => error
      Rails.logger.error error
    end
  end
end