class Course < ApplicationRecord
  has_many :sections, dependent: :destroy
  has_many :grader_applications
  has_many :meetings, through: :sections, dependent: :destroy


  validates :course_number, presence: true, uniqueness: true
  validates :course_name, presence: true
  validates :course_description, presence: true
  validates :credits, presence: true

  def self.search(term)
    if term
      where('LOWER(course_name) LIKE ?', "%#{term.downcase}%")
    else
      all
    end
  end

  def self.sort_by_column(column)
    case column
    when 'name'
      order(:course_name)
    when 'date'
      order(:created_at)
    else
      all
    end
  end
end
