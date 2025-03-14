class UsersController < ApplicationController

  def index
    users = User
              .by_company(search_params[:company_identifier])
              .by_username(search_params[:username])
    render json: users
  end

  private

  def search_params
    params.permit(:username, :company_identifier)
  end
end
