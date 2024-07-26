class AddAllApiAttributesToSections < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :section, :string
    add_column :sections, :course_offering_number, :integer
    add_column :sections, :academic_group, :string
    add_column :sections, :subject, :string
    add_column :sections, :catalog_number, :string
    add_column :sections, :career, :string
    add_column :sections, :description, :text
    add_column :sections, :consent, :boolean
    add_column :sections, :minimum_enrollment, :integer
    add_column :sections, :academic_org, :string
    add_column :sections, :location, :string
    add_column :sections, :equivalent_course_id, :string
    add_column :sections, :cancel_date, :date
    add_column :sections, :combined_section, :string
    add_column :sections, :holiday_schedule, :string
    add_column :sections, :sec_campus, :string
    add_column :sections, :sec_academic_group, :string
    add_column :sections, :sec_catalog_number, :string
    add_column :sections, :meeting_days, :string
  end
end
