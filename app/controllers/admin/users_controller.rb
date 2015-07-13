class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "admin.update_successfully"
    else
      flash[:failed] = t "admin.update_fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_root_url}
      format.js
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.destroy_successfully"
    else
      flash[:failed] = t "admin.destroy_fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_root_url}
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit :admin
  end

  def set_user
    @user = User.find params[:id]
  end
end
