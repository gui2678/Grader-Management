# app/controllers/admin_controller.rb
class AdminController < ApplicationController
    before_action :authenticate_user!  # Ensure only authenticated users can access these actions
  
    def test
      # Render the test page
    end
  
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
  
      redirect_to admin_database_test_path
    end
  end
  