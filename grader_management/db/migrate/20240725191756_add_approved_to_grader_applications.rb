class AddApprovedToGraderApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :grader_applications, :approved, :boolean, default: false
  end
end
