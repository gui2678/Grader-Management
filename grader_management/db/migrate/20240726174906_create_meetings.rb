class CreateMeetings < ActiveRecord::Migration[6.1]
  def change
    change_table :sections do |t|
      t.references :course, null: false, foreign_key: true unless column_exists?(:sections, :course_id)
      t.string :class_number, null: false unless column_exists?(:sections, :class_number)
      t.string :section_number, null: false unless column_exists?(:sections, :section_number)
      t.string :component, null: false unless column_exists?(:sections, :component)
      t.string :instruction_mode unless column_exists?(:sections, :instruction_mode)
      t.date :start_date unless column_exists?(:sections, :start_date)
      t.date :end_date unless column_exists?(:sections, :end_date)
      t.string :enrollment_status unless column_exists?(:sections, :enrollment_status)
      t.string :status unless column_exists?(:sections, :status)
      t.string :type unless column_exists?(:sections, :type)
      t.string :associated_class unless column_exists?(:sections, :associated_class)
      t.boolean :auto_enroll_waitlist unless column_exists?(:sections, :auto_enroll_waitlist)
      t.string :auto_enroll_section1 unless column_exists?(:sections, :auto_enroll_section1)
      t.string :auto_enroll_section2 unless column_exists?(:sections, :auto_enroll_section2)
      t.boolean :consent unless column_exists?(:sections, :consent)
      t.integer :waitlist_capacity unless column_exists?(:sections, :waitlist_capacity)
      t.integer :minimum_enrollment unless column_exists?(:sections, :minimum_enrollment)
      t.integer :enrollment_total unless column_exists?(:sections, :enrollment_total)
      t.integer :waitlist_total unless column_exists?(:sections, :waitlist_total)
      t.string :location unless column_exists?(:sections, :location)
      t.string :primary_instructor_section unless column_exists?(:sections, :primary_instructor_section)
      t.string :combined_section unless column_exists?(:sections, :combined_section)
      t.string :holiday_schedule unless column_exists?(:sections, :holiday_schedule)
      t.string :session_code unless column_exists?(:sections, :session_code)
      t.string :session_description unless column_exists?(:sections, :session_description)
      t.string :term unless column_exists?(:sections, :term)
      t.string :campus unless column_exists?(:sections, :campus)
      t.jsonb :attributes unless column_exists?(:sections, :attributes)
      t.time :start_time unless column_exists?(:sections, :start_time)
      t.time :end_time unless column_exists?(:sections, :end_time)
      t.string :days unless column_exists?(:sections, :days)

      t.timestamps unless column_exists?(:sections, :created_at)
    end
    
    add_index :sections, :class_number, unique: true unless index_exists?(:sections, :class_number)
  end
end
