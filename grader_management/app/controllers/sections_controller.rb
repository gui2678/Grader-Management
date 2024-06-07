class SectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @course = Course.find(params[:course_id])
    @sections = @course.sections
  end

  def show
    @section = Section.find(params[:id])
  end
end
