class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :section, null: false, foreign_key: true
      t.integer :student_id

      t.timestamps
    end
  end
end
