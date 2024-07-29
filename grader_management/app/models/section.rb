class Section < ApplicationRecord
  belongs_to :course
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id', optional: true
  has_many :meetings, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user
  has_many :grader_applications
  validates :section_number, presence: true
  validates :class_number, presence: true
  validates :component, presence: true
  validates :term, presence: true
  validates :campus, presence: true
  
  def primary_instructor
    instructor&.name
  end

  def meeting_days
    meetings.map(&:meeting_days).join(", ")
  end

  def start_time
    meetings.minimum(:start_time)
  end

  def end_time
    meetings.maximum(:end_time)
  end
end