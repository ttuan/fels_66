class Admin::WordsController < ApplicationController
  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_parmas
    if @word.save
      flash[:success] = t "category.create_successfully"
      redirect_to new_admin_word_path
    else
      flash[:fail] = t "category.create_fail" 
      render "new" 
    end 
  end
  
  private 
  def word_parmas
    params.require(:word).permit :alphabet, :category_id,
      answers_attributes: [:ans, :status, :_destroy]
  end 
end
