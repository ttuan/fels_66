class Admin::CategoriesController < ApplicationController
  before_action :require_admin
  before_action :set_category, only: [:show, :edit, :destroy]
  
  def new
    @category = Category.new
    @categories = Category.ordered_by_create_at.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
  end 

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.create_successfully"
    else
      flash[:fail] = t "category.create_fail"
    end  
    redirect_to new_admin_category_path
  end 

  def edit
    remenber_category @category
    redirect_to new_admin_word_path
  end

  def destroy
    @category.destroy
    flash[:success] = t "admin.delete_success"
    redirect_to new_admin_category_path
  end
  
  private
  def category_params
    params.require(:category).permit :name
  end 

  def require_admin
    unless current_user
      redirect_to root_path
    end
  end

  def set_category
    @category = Category.find params[:id]
  end  
end
