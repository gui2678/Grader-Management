class AddCourseAttributesJsonToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :course_attributes_json, :text
  end
end
