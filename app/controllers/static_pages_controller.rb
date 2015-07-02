class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_activities = current_user.feed.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
