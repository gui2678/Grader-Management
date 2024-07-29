# app/controllers/sections_controller.rb
class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:index, :show, :edit, :update]
  before_action :set_section, only: [:show, :edit, :update]

  def index
    @sections = @course.sections
  end

  def show
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to course_path(@course), notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_section
    @section = @course.sections.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:section_number, :class_number, :component, :start_date, :end_date, :max_graders)
  end
end
