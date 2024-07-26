class AddInstructorIdToSections < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:sections, :instructor_id)
      add_column :sections, :instructor_id, :integer
    end
  end
end
