class UpdateCoursesTable < ActiveRecord::Migration[7.0]
  def change
    change_table :courses do |t|
      t.string :term, null: false unless column_exists?(:courses, :term)
      t.date :effective_date, null: false unless column_exists?(:courses, :effective_date)
      t.string :effective_status, null: false unless column_exists?(:courses, :effective_status)
      t.string :title unless column_exists?(:courses, :title)
      t.string :short_description, null: false unless column_exists?(:courses, :short_description)
      t.text :course_description, null: false unless column_exists?(:courses, :course_description)
      t.string :equivalent_id unless column_exists?(:courses, :equivalent_id)
      t.string :allow_multi_enroll, null: false unless column_exists?(:courses, :allow_multi_enroll)
      t.integer :max_units, null: false unless column_exists?(:courses, :max_units)
      t.integer :min_units, null: false unless column_exists?(:courses, :min_units)
      t.integer :repeat_units_limit, null: false unless column_exists?(:courses, :repeat_units_limit)
      t.string :grading, null: false unless column_exists?(:courses, :grading)
      t.string :component, null: false unless column_exists?(:courses, :component)
      t.string :primary_component, null: false unless column_exists?(:courses, :primary_component)
      t.integer :offering_number, null: false unless column_exists?(:courses, :offering_number)
      t.string :academic_group, null: false unless column_exists?(:courses, :academic_group)
      t.string :subject, null: false unless column_exists?(:courses, :subject)
      t.string :catalog_number, null: false unless column_exists?(:courses, :catalog_number)
      t.string :campus, null: false unless column_exists?(:courses, :campus)
      t.string :academic_org, null: false unless column_exists?(:courses, :academic_org)
      t.string :academic_career, null: false unless column_exists?(:courses, :academic_career)
      t.string :cip_code, null: false unless column_exists?(:courses, :cip_code)
      t.string :campus_code, null: false unless column_exists?(:courses, :campus_code)
      t.string :catalog_level, null: false unless column_exists?(:courses, :catalog_level)
      t.string :subject_desc, null: false unless column_exists?(:courses, :subject_desc)
      t.text :course_attributes unless column_exists?(:courses, :course_attributes)
      t.string :course_id, null: false unless column_exists?(:courses, :course_id)
    end
  end
end
