class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [:new, :create, :edit, :update, :destroy, :do_reload_courses]

  def index
    @courses = Course.all

    if params[:search].present?
      search_term = params[:search].downcase
      @courses = @courses.search(search_term)
    end

# Ensures courses are sorted by the specific attribute that the user chooses
    if params[:sort_by].present?
      @courses = @courses.sort_by_column(params[:sort_by])
    end
  end

  def show
    @course = Course.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Sorry! Course not found"
    redirect_to courses_path
  end

  def new
      @course = Course.new
  end

  def edit
      @course = Course.find(params[:id])
  end

  def create
      @course = Course.new(course_params)

      if @course.save
        redirect_to @course
      else
        render 'new'
      end
  end

  def update
      @course = Course.find(params[:id])

      if @course.update(course_params)
        flash[:notice] = "Success! See below for your updated course!"
        redirect_to courses_path
      else
        render 'edit'
      end
  end

  def destroy
      @course = Course.find(params[:id])
      if @course.destroy
        flash[:notice] = "Course has been deleted successfully."
      else
        flash[:alert] = "Error deleting course."
      end
      redirect_to courses_path
  end

  def do_reload_courses
    term = params[:term]
    campus = params[:campus]

    if term.present? && campus.present?
      if call_fetch_class_info(term, campus)
        flash[:notice] = "Class information imported successfully."
      else
        flash[:alert] = "There was an error importing class information."
      end
    else
      flash[:alert] = "Term and campus are required to reload courses."
    end
    redirect_to courses_path
  end

  
  private
def course_params
        params.require(:course).permit(:course_number, :course_name, :course_description, :credits)
  end

  def call_fetch_class_info(term, campus)
    fetcher = FetchClassInfo.new(term: term, campus: campus)

    if fetcher.call
      true
    else
      Rails.logger.error "FetchClassInfo service failed for term: #{term}, campus: #{campus}"
      false
    end
  end

  def verify_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
