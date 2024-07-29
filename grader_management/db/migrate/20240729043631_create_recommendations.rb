class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.references :recommender, null: false, foreign_key: { to_table: :users }
      t.references :recommended, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true
      t.text :message, null: false

      t.timestamps
    end
  end
end