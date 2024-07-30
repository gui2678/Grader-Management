class ChangeRecommendedIdInRecommendations < ActiveRecord::Migration[6.0]
  def change
    change_column :recommendations, :recommended_id, :integer, null: true
  end
end
