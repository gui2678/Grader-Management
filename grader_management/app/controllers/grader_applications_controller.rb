class GraderApplicationsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :authorize_admin_or_instructor!, only: [:approve]
  before_action :authorize_student!, only: [:index, :show, :new, :edit, :destroy]

  def index
    if current_user.admin? || current_user.instructor?
      @pagy, @grader_applications = pagy(GraderApplication.all)
    elsif current_user.student?
      @pagy, @grader_applications = pagy(GraderApplication.where(user_id: current_user.id))
    end
    @grader_application = GraderApplication.new
  end

  def show
    @grader_application = GraderApplication.find(params[:id])
  end

  def new
    @grader_application = GraderApplication.new
  end

  def create
    @grader_application = GraderApplication.new(grader_application_params)
    @grader_application.user = current_user

    if @grader_application.save
      redirect_to @grader_application, notice: 'Grader Application was successfully created.'
    else
      render :new
    end
  end

  def edit
    @grader_application = GraderApplication.find(params[:id])
  end

  def update
    @grader_application = GraderApplication.find(params[:id])
    if @grader_application.update(grader_application_params)
      redirect_to @grader_application, notice: 'Grader Application was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @grader_application = GraderApplication.find(params[:id])
    @grader_application.destroy
    redirect_to grader_applications_url, notice: 'Grader Application was successfully destroyed.'
  end

  def approve
    @grader_application = GraderApplication.find(params[:id])
    @grader_application.update(approved: !@grader_application.approved)
    @status_message = @grader_application.approved ? "Application approved successfully." : "Application unapproved successfully."

    respond_to do |format|
      format.html { redirect_to grader_applications_path, notice: @status_message }
      format.js   # This will render `approve.js.erb`
    end
  end

  private

  def grader_application_params
    params.require(:grader_application).permit(:display_name, :first_name, :middle_name, :last_name, :legal_last_name, :name_suffix, :username, :email, :address, :phone, :course_id, :section_id)
  end

  def authorize_admin_or_instructor!
    unless current_user.admin? || current_user.instructor?
      redirect_to root_path, alert: 'You are not authorized to view this page.'
    end
  end

  def authorize_student!
    if current_user.student? && !%w[index show new edit destroy].include?(action_name)
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end