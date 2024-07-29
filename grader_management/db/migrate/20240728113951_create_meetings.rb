class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:meetings)
      create_table :meetings do |t|
        t.references :course, null: false, foreign_key: true
        t.references :section, null: false, foreign_key: true
        t.string :class_number, null: false
        t.string :section_number, null: false
        t.string :component, null: false
        t.string :instruction_mode
        t.date :start_date
        t.date :end_date
        t.string :enrollment_status
        t.string :status
        t.string :section_type
        t.integer :associated_class
        t.boolean :auto_enroll_waitlist
        t.string :auto_enroll_section1
        t.string :auto_enroll_section2
        t.boolean :consent
        t.integer :waitlist_capacity
        t.integer :minimum_enrollment
        t.integer :enrollment_total
        t.integer :waitlist_total
        t.integer :facility_id
        t.string :facility_type
        t.string :facility_description
        t.string :facility_description_short
        t.integer :facility_capacity
        t.string :building_code
        t.string :room
        t.string :building_description
        t.string :building_description_short
        t.time :start_time
        t.time :end_time
        t.boolean :monday, default: false
        t.boolean :tuesday, default: false
        t.boolean :wednesday, default: false
        t.boolean :thursday, default: false
        t.boolean :friday, default: false
        t.boolean :saturday, default: false
        t.boolean :sunday, default: false
        t.string :location
        t.string :primary_instructor_section
        t.string :combined_section
        t.string :holiday_schedule
        t.string :session_code
        t.string :session_description
        t.string :term
        t.string :campus
        t.jsonb :meeting_attributes_json

        t.timestamps
      end

      add_index :meetings, :class_number, unique: true
    end
  end
end
