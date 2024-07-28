class Course < ApplicationRecord
    has_many :sections
    has_many :grader_applications
    has_many :meetings, through: :sections, dependent: :destroy

  
    validates :course_number, presence: true, uniqueness: true
    validates :course_name, presence: true
    validates :course_description, presence: true
    validates :credits, presence: true

    serialize :course_attributes_json, JSON

  end
  