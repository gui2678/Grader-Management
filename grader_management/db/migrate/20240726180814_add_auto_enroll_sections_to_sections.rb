class AddAutoEnrollSectionsToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :auto_enroll_section1, :string
    add_column :sections, :auto_enroll_section2, :string
  end
end
