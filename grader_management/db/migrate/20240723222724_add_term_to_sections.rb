class AddTermToSections < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:sections, :term)
      add_column :sections, :term, :string
    end
  end
end
