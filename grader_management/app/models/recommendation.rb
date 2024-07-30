class Recommendation < ApplicationRecord
  belongs_to :recommender, class_name: 'User'
  belongs_to :recommended, class_name: 'User', optional: true
  belongs_to :course

  validates :course_id, presence: true
  validates :section_number, presence: true
  validates :message, presence: true

  # Optional validation to ensure either recommended user or username is present
  validate :recommended_or_username_present

  private

  def recommended_or_username_present
    if recommended_id.blank? && username.blank?
      errors.add(:base, "Either recommended user or username must be provided")
    end
  end
end
