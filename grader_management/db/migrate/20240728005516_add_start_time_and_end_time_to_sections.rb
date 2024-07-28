class AddStartTimeAndEndTimeToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :start_time, :time unless column_exists?(:sections, :start_time)
    add_column :sections, :end_time, :time unless column_exists?(:sections, :end_time)
  end
end
