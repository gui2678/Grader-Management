class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :course_id
      t.string :class_number
      t.string :component
      t.time :start_time
      t.time :end_time
      t.string :days

      t.timestamps
    end
  end
end