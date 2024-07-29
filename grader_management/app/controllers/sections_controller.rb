# app/controllers/sections_controller.rb
class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:index, :show, :edit, :update]
  before_action :set_section, only: %i[ show edit update destroy ]

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

  def manage
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :manage }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:course_id, :section_number, :instructor, :schedule)
  end
end
