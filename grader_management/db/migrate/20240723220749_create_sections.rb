class CreateSections < ActiveRecord::Migration[6.0]
  def change
    unless table_exists?(:sections)
      create_table :sections do |t|
        t.string :section_number
        t.string :term
        t.string :campus
        t.string :schedule

        t.timestamps
      end
    end
  end
end

