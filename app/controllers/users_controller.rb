class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :set_users

  authorize_resource

  def index
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    @users = User.order(score: :desc, username: :asc).page(params[:page]).per(10)
  end
end
