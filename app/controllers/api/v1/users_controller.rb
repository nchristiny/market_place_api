class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    respond_with User.find(params[:id])
  end
end
