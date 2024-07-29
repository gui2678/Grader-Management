class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:index, :show, :edit, :update, :view_graders, :sections_for_course]
  before_action :set_section, only: [:show, :edit, :update, :destroy, :view_graders]

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

  def view_graders
    @graders = @section.grader_applications.where(approved: true)
  end

  def sections_for_course
    @sections = Section.where(course_id: params[:course_id])
    respond_to do |format|
      format.json { render json: @sections }
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_section
    @section = @course.sections.find_by(id: params[:id])
    unless @section
      flash[:alert] = "Section not found."
      redirect_to courses_path
    end
  end

  def section_params
    params.require(:section).permit(:section_number, :class_number, :component, :start_date, :end_date, :max_graders)
  end
end
