class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :approver, class_name: 'User', foreign_key: 'approved_by'

  validates :user_id, presence: true
  validates :approved_by, presence: true
  validates :approved_at, presence: true
end
