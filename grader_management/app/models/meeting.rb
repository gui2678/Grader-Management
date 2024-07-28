class Meeting < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :section
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id', optional: true

  validates :class_number, presence: true
  validates :section_number, presence: true
  validates :component, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
