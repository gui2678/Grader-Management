class Course < ApplicationRecord
    has_many :sections, dependent: :destroy
  has_many :grader_applications
  
    validates :course_number, presence: true, uniqueness: true
    validates :course_name, presence: true
    validates :course_description, presence: true
    validates :credits, presence: true
  end
  