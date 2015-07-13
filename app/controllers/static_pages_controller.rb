class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_activities = Activity.feed_all(current_user.following_ids, current_user).recent
        .paginate page: params[:page], per_page: Settings.per_page
      @results = Result.results_by_user(current_user.lessons.pluck(:id))
    end
  end
end
