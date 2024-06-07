class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_number, null: false
      t.string :course_name, null: false
      t.text :course_description, null: false
      t.integer :credits, null: false

      t.timestamps
    end

    add_index :courses, :course_number, unique: true
  end
end
