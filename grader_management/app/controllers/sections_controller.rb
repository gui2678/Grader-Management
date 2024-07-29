class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_section, only: %i[ show edit update destroy ]

  def index
    @course = Course.find(params[:course_id])
    @sections = @course.sections
  end

  def show
    @section = Section.find(params[:id])
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
