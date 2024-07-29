class CreateSections < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:sections)
      create_table :sections do |t|
        t.references :course, null: false, foreign_key: true
        t.string :class_number, null: false
        t.string :section_number, null: false
        t.string :component, null: false
        t.string :instruction_mode
        t.date :start_date
        t.date :end_date
        t.string :enrollment_status
        t.string :status
        t.string :type
        t.string :associated_class
        t.boolean :auto_enroll_waitlist
        t.string :auto_enroll_section1
        t.string :auto_enroll_section2
        t.boolean :consent
        t.integer :waitlist_capacity
        t.integer :minimum_enrollment
        t.integer :enrollment_total
        t.integer :waitlist_total
        t.string :location
        t.string :primary_instructor_section
        t.string :combined_section
        t.string :holiday_schedule
        t.string :session_code
        t.string :session_description
        t.string :term
        t.string :campus
        t.jsonb :meeting_attributes_json
        t.time :start_time
        t.time :end_time
        t.string :days
        t.string :schedule

        t.timestamps
      end

      add_index :sections, :class_number, unique: true
    end
  end
end
