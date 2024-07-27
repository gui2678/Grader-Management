class CreateGraderApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :grader_applications do |t|
      t.string :display_name, null: false
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
      t.string :legal_last_name, null: false
      t.string :name_suffix, null: true  # Allow null
      t.string :username, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.string :phone, null: false
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.references :section, foreign_key: true
      t.timestamps
    end
  end
end
