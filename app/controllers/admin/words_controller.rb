  class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  before_action :require_category_id
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "admin.create_successfully"
      respond_to do |format|
        format.html {redirect_to admin_words_path}
        format.js
      end
    else
      flash[:danger] = t "admin.create_fail" 
      render "index" 
    end 
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "admin.update_successfully"
    else
      flash[:danger] = t "admin.update_fail"
    end
    redirect_to admin_words_path
  end  
  
  def destroy
    if @word.destroy
      flash[:success] = t "admin.destroy_successfully"  
    else
      flash[:failed] = t "admin.destroy_fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_words_path}
      format.js
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
      flash[:danger] = t "admin.word.need_category_id"
      redirect_to admin_categories_path
    end
  end
end
