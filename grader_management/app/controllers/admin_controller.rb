class AdminController < ApplicationController
  before_action :authenticate_user!, only: [:test, :fetch_class_info]

  def test
    @courses = Course.all
  end

  def fetch_class_info
    fetcher = FetchClassInfo.new(term: params[:term], campus: params[:campus])
    fetcher.call
    redirect_to admin_database_test_path, notice: 'Class information fetched successfully.'
  end
end
