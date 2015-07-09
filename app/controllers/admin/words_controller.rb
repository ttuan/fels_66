  class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  before_action :require_category_id
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def index
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "category.create_successfully"
      respond_to do |format|
        format.html {redirect_to new_admin_word_path}
        format.js
      end
    else
      flash.now[:danger] = t "category.create_fail" 
      render "new" 
    end 
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "admin.update_success"
    else
      flash[:danger] = t "admin.fail"
    end
    redirect_to new_admin_word_path
  end  
  
  def destroy
    if @word.destroy
      flash[:success] = t "admin.delete_success"
      respond_to do |format|
        format.html {redirect_to new_admin_word_path}
        format.js
      end
    else
      flash[:failed] = t "admin.delete_fail"
    end
  end

  private
  def word_params
    params.require(:word).permit :alphabet, :category_id,
      answers_attributes: [:id, :ans, :status, :_destroy]
  end

  def set_word
    @word = Word.find params[:id]
  end

  def require_category_id
    unless !session[:category_id].nil?
      flash[:danger] = t "category.need_category_id"
      redirect_to new_admin_category_path
    end
  end
end
