class RenameAttributesInSections < ActiveRecord::Migration[6.1]
  def change
    rename_column :sections, :attributes, :section_attributes
  end
end
