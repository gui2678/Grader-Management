class Meeting < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :section
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id', optional: true

  validates :class_number, presence: true
  validates :section_number, presence: true
  validates :component, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def instructors
    JSON.parse(instructors_json || '[]')
  rescue JSON::ParserError
    []
  end

  def meeting_days
    days = []
    days << 'Monday' if self.monday
    days << 'Tuesday' if self.tuesday
    days << 'Wednesday' if self.wednesday
    days << 'Thursday' if self.thursday
    days << 'Friday' if self.friday
    days << 'Saturday' if self.saturday
    days << 'Sunday' if self.sunday
    days.join(', ')
  end
end
