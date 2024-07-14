class AddMissingColumnsToSections < ActiveRecord::Migration[7.0]
  def change
    change_table :sections do |t|
      t.string :class_number unless column_exists? :sections, :class_number
      t.string :component unless column_exists? :sections, :component
      t.time :start_time unless column_exists? :sections, :start_time
      t.time :end_time unless column_exists? :sections, :end_time
      t.string :days unless column_exists? :sections, :days
      t.references :course, foreign_key: true unless column_exists? :sections, :course_id
    end
  end
end
