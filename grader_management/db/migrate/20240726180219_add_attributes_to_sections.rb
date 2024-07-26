class AddAttributesToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :instruction_mode, :string
    add_column :sections, :enrollment_status, :string
    add_column :sections, :status, :string
    add_column :sections, :section_type, :string
    add_column :sections, :associated_class, :string
    add_column :sections, :auto_enroll_waitlist, :boolean
    add_column :sections, :waitlist_capacity, :integer
    add_column :sections, :enrollment_total, :integer
    add_column :sections, :primary_instructor_section, :string
    add_column :sections, :session_code, :string
    add_column :sections, :session_description, :string
    add_column :sections, :attributes, :jsonb
  end
end
