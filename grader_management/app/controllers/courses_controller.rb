# app/controllers/admin/courses_controller.rb
class CoursesController < ApplicationController
  before_action :authenticate_user!

  def fetch_class_info
    term = params[:term]
    campus = params[:campus]
    
    # Initialize and call the FetchClassInfo service
    fetcher = FetchClassInfo.new(term: term, campus: campus)
    
    if fetcher.call
      flash[:notice] = "Class information imported successfully."
    else
      flash[:alert] = "There was an error importing class information."
    end
    
    redirect_to admin_courses_path
  end

  def index
    @courses = Course.all
    @flash_notice = flash[:notice] if flash[:notice]
  end

  def show
    @course = Course.find(params[:id])
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
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
  @course.destroy

    redirect_to courses_path
  end

  def reload_courses
    
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
    params.require(:course).permit(:title, :text)
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

  def course_params
    params.require(:course).permit(:title, :text)
  end

  def verify_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
