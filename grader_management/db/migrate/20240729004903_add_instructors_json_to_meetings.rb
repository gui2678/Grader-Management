class AddInstructorsJsonToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :instructors_json, :text
  end
end
