class AddCourseFields < ActiveRecord::Migration[7.0]
  def change
    change_table :courses do |t|
      t.string :term
      t.date :effective_date
      t.string :effective_status
      t.string :title
      t.string :short_description
      t.text :description
      t.string :equivalent_id
      t.string :allow_multi_enroll
      t.integer :max_units
      t.integer :min_units
      t.integer :repeat_units_limit
      t.string :grading
      t.string :component
      t.string :primary_component
      t.integer :offering_number
      t.string :academic_group
      t.string :subject
      t.string :catalog_number
      t.string :campus
      t.string :academic_org
      t.string :academic_career
      t.string :cip_code
      t.string :campus_code
      t.string :catalog_level
      t.string :subject_desc
      t.text :course_attributes
      t.string :course_id
    end
  end
end
