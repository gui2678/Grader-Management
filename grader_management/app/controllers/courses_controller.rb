class CoursesController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :verify_admin, only: [:do_reload_courses, :new, :create, :edit, :update, :destroy, :do_reload_courses]

  def fetch_class_info
    term = params[:term]
    campus = params[:campus]
    
    fetcher = FetchClassInfo.new(term: term, campus: campus)
    
    if fetcher.call
      flash[:notice] = "Class information imported successfully."
    else
      flash[:alert] = "There was an error importing class information."
    end
    
    redirect_to admin_courses_path
  end

  def index
    if params[:search].present?
      search_term = params[:search].downcase
      @courses = Course.search(search_term)
      if @courses.empty?
        flash.now[:notice] = "There are no courses found for these params."
        @pagy, @courses = pagy(Course.none, items: 10)
      else
        @pagy, @courses = pagy(@courses, items: 10)
      end
    else
      @pagy, @courses = pagy(Course.all, items: 10)
    end

    if params[:sort_by] == 'name'
      @courses = @courses.order(course_name: :asc)
    elsif params[:sort_by] == 'date'
      @courses = @courses.order(created_at: :desc)
    end

    @pagy, @courses = pagy(@courses, items: 10)
  end

  def show
    @course = Course.includes(sections: :meetings).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Sorry! Course not found"
    redirect_to courses_path
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.includes(sections: :meetings).find(params[:id])
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: "Course successfully created."
    else
      flash.now[:alert] = @course.errors.full_messages.to_sentence
      render 'new'
    end
  rescue ActionController::ParameterMissing => e
    @course = Course.new
    flash.now[:alert] = "Please fill in all required fields."
    render 'new'
  end

  def update
    @course = Course.find(params[:id])
    
    if @course.update(course_params)
      flash[:notice] = "Success! See below for your updated course!"
      redirect_to course_path(@course, search: params[:search], sort_by: params[:sort_by])
    else
      flash.now[:alert] = @course.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url(search: params[:search], sort_by: params[:sort_by]), notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def reload_courses
  end

  def do_reload_courses
    term = params[:term]
    campus = params[:campus]
  
    if term.present? && campus.present?

      GraderApplication.delete_all
      Recommendation.delete_all

      Meeting.delete_all
      Section.delete_all
      Course.delete_all
  
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
    params.require(:course).permit(
      :course_number, :course_name, :course_description, :credits, 
      :term, :effective_date, :effective_status, :title, :short_description, 
      :equivalent_id, :allow_multi_enroll, :max_units, :min_units, :repeat_units_limit, 
      :grading, :component, :primary_component, :offering_number, :academic_group, 
      :subject, :catalog_number, :campus, :academic_org, :academic_career, :cip_code, 
      :campus_code, :catalog_level, :subject_desc, :course_attributes_json, 
      sections_attributes: [:id, :max_graders, :number_of_graders]
    )
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
