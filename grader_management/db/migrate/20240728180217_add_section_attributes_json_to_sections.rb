class AddSectionAttributesJsonToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :section_attributes_json, :text
  end
end
