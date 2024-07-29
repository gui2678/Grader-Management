class AddStartDateAndEndDateToSections < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :start_date, :date unless column_exists?(:sections, :start_date)
    add_column :sections, :end_date, :date unless column_exists?(:sections, :end_date)
  end
end
