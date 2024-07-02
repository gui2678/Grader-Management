class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_number
      t.string :course_name
      t.text :course_description
      t.integer :credits

      t.timestamps
    end
  end
end
