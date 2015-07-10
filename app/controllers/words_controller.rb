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
    respond_to do |format|
      format.js
      format.html
      format.csv {send_data @words.to_csv}
    end
  end
end
