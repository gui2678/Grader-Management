class AddNameToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :name, :string
  end
end
