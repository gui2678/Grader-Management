class Section < ApplicationRecord
  belongs_to :course
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id'
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :section_number, presence: true
  validates :term, presence: true
  validates :campus, presence: true
  validates :schedule, presence: true
end