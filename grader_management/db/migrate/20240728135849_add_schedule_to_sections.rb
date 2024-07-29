class AddScheduleToSections < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:sections)
    add_column :sections, :schedule, :string
  end
end
end