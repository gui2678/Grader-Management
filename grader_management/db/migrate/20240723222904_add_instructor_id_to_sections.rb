class AddInstructorIdToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :instructor_id, :integer
  end
end
