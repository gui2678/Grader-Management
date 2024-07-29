class AddAutoEnrollSectionsToSections < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :auto_enroll_section1, :string unless column_exists?(:sections, :auto_enroll_section1)
    add_column :sections, :auto_enroll_section2, :string unless column_exists?(:sections, :auto_enroll_section2)
  end
end
