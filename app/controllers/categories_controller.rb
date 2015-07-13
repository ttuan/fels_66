class CategoriesController < ApplicationController
  before_action :logged_in_user 

  def index
    @categories = if params[:search_category]
      Category.search_category(params[:search_category]).recent
        .paginate page: params[:page], per_page: Settings.per_page
    elsif params[:filter_state]
      Category.send(params[:filter_state], current_user.id).recent
        .paginate page: params[:page], per_page: Settings.per_page
    else
      Category.recent.paginate page: params[:page], per_page: Settings.per_page
    end
  end
end
