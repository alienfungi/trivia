class UsersController < ApplicationController
  before_action :set_user

  authorize_resource

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
