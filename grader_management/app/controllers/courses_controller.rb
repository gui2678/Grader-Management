# app/controllers/admin/courses_controller.rb
module Admin
  class CoursesController < ApplicationController
    before_action :authenticate_admin!

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
  end
end
