class AddSectionNumberToSection < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :section_number, :integer
  end
end
