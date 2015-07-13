class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  
  def index
    @lessons = current_user.lessons
  end

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

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson.finished"
      redirect_to lesson_path @lesson
    else
      render "edit"
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, results_attributes: [:id, :status, :word_id]
  end

  def set_lesson
    @lesson = Lesson.find params[:id]
  end
end
