class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.string :section_number
      t.references :course, null: false, foreign_key: true
      t.integer :instructor_id
      t.string :term
      t.string :campus
      t.string :schedule

      t.timestamps
    end
  end
end
