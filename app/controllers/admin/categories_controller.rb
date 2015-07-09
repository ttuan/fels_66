class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  before_action :set_category, only: [:show, :edit, :destroy]

  def index
    @categories = Category.ordered_by_create_at
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.create_successfully"
    else
      flash[:fail] = t "category.create_fail"
    end
    respond_to do |format|
      format.html {redirect_to new_admin_category_path}
      format.js
    end
  end

  def edit
    remember_category @category
    redirect_to admin_words_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.delete_success"
      respond_to do |format|
        format.html {redirect_to new_admin_category_path}
        format.js
      end
    else
      flash[:failed] = t "admin.delete_fail"
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def set_category
    @category = Category.find params[:id]
  end
end
