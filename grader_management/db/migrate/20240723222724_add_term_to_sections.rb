class AddTermToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :term, :string
    add_column :sections, :campus, :string
    add_column :sections, :schedule, :string
  end
end
