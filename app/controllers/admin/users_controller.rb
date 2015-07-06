class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "word.success"
    else
      flash[:danger] = t "word.fail"
    end
    redirect_to admin_root_url
  end

  def destroy
    @user.destroy
    flash[:success] = t "admin.delete_success"
    redirect_to admin_root_url
  end

  private
  def user_params
    params.require(:user).permit :admin
  end

  def set_user
    @user = User.find params[:id]
  end  
end
