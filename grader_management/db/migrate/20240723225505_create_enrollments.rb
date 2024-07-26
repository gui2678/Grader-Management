class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    unless table_exists?(:enrollments)
      create_table :enrollments do |t|
        t.integer :student_id
        t.integer :section_id
        t.timestamps
      end
    end
  end
end
