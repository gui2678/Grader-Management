class AddNumberOfGradersToCourses < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:sections, :number_of_graders)
      add_column :sections, :number_of_graders, :integer
    end
  end
end
