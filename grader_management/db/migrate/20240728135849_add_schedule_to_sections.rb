class AddScheduleToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :schedule, :string
  end
end
