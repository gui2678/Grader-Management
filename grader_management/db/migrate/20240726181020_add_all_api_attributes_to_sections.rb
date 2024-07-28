class AddAllApiAttributesToSections < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :section, :string unless column_exists?(:sections, :section)
    add_column :sections, :course_offering_number, :integer unless column_exists?(:sections, :course_offering_number)
    add_column :sections, :academic_group, :string unless column_exists?(:sections, :academic_group)
    add_column :sections, :subject, :string unless column_exists?(:sections, :subject)
    add_column :sections, :catalog_number, :string unless column_exists?(:sections, :catalog_number)
    add_column :sections, :career, :string unless column_exists?(:sections, :career)
    add_column :sections, :description, :text unless column_exists?(:sections, :description)
    add_column :sections, :consent, :boolean unless column_exists?(:sections, :consent)
    add_column :sections, :minimum_enrollment, :integer unless column_exists?(:sections, :minimum_enrollment)
    add_column :sections, :academic_org, :string unless column_exists?(:sections, :academic_org)
    add_column :sections, :location, :string unless column_exists?(:sections, :location)
    add_column :sections, :equivalent_course_id, :string unless column_exists?(:sections, :equivalent_course_id)
    add_column :sections, :cancel_date, :date unless column_exists?(:sections, :cancel_date)
    add_column :sections, :combined_section, :string unless column_exists?(:sections, :combined_section)
    add_column :sections, :holiday_schedule, :string unless column_exists?(:sections, :holiday_schedule)
    add_column :sections, :sec_campus, :string unless column_exists?(:sections, :sec_campus)
    add_column :sections, :sec_academic_group, :string unless column_exists?(:sections, :sec_academic_group)
    add_column :sections, :sec_catalog_number, :string unless column_exists?(:sections, :sec_catalog_number)
    add_column :sections, :meeting_days, :string unless column_exists?(:sections, :meeting_days)
  end
end
