class AddDaysToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :days, :string unless column_exists?(:sections, :days)
  end
end
