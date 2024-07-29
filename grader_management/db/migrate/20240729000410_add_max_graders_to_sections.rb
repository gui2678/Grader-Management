class AddMaxGradersToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :max_graders, :integer
  end
end
