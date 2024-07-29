class AddMeetingNumberToMeetings < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:meetings, :meeting_number)
      add_column :meetings, :meeting_number, :string
    end
  end
end
