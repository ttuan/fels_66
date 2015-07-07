class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  
  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "lesson.success"
      redirect_to edit_lesson_path @lesson
    else
      flash[:danger] = t "lesson.fail"
      redirect_to categories_path
    end
  end

  def show
    @results = @lesson.results
  end

  def edit
    @words = @lesson.words
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id
  end

  def set_lesson
    @lesson = Lesson.find params[:id]
  end
end
