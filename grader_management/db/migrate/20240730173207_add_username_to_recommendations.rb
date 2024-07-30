class AddUsernameToRecommendations < ActiveRecord::Migration[7.0]
  def change
    add_column :recommendations, :username, :string
  end
end
