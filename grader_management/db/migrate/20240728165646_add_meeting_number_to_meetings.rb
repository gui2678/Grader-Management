class AddMeetingNumberToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :meeting_number, :string
  end
end
