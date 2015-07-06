class WordsController < ApplicationController
  def index
    @categories = Category.all
    @words = if params[:search]
      Word.search_word(params[:search]).recent
    elsif params[:filter_state]
      Word.filter_category(params[:category_id]).send(params[:filter_state], current_user.id).recent
    else
      Word.recent
    end
  end
end
