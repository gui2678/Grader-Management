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

  private
  def course_params
    params.require(:course).permit(:title, :text)
  end
end
