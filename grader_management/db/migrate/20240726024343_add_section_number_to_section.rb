class AddSectionNumberToSection < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:sections, :section_number)
      add_column :sections, :section_number, :integer
    end
  end
end
