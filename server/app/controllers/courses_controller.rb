
class CoursesController < ApplicationController
  before_action only: [:edit, :update, :destroy] do
    check_permission('edit_catalog')
  end

  def index
    @courses = Course.all
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :instructor_id)
  end
end
