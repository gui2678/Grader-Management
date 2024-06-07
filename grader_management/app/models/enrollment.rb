class Enrollment < ApplicationRecord
  belongs_to :section
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'

  validates :section_id, presence: true
  validates :student_id, presence: true
end
