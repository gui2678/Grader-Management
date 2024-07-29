class Recommendation < ApplicationRecord
  belongs_to :recommender, class_name: 'User'
  belongs_to :recommended, class_name: 'User'
  belongs_to :course

  validates :recommender_id, :recommended_id, :course_id, :message, presence: true
end
