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
      flash[:failed] = t "word.fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_root_url}
      format.js
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.delete_success"
      @users = User.all
      respond_to do |format|
        format.html {redirect_to admin_root_url}
        format.js
      end
    else
      flash[:failed] = t "admin.delete_fail"
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
