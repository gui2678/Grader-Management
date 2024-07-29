class CreateGraderApplicationsagain < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:grader_applications)
      create_table :grader_applications do |t|
        t.string :display_name, null: false
        t.string :first_name, null: false
        t.string :middle_name
        t.string :last_name, null: false
        t.string :legal_last_name, null: false
        t.string :name_suffix
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
end
