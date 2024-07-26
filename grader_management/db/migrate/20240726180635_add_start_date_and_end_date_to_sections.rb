class AddStartDateAndEndDateToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :start_date, :date
    add_column :sections, :end_date, :date
  end
end
