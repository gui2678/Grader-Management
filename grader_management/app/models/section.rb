class Section < ApplicationRecord
  belongs_to :course
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id', optional: true
  has_many :meetings, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  # Only keep presence validations for essential attributes
  validates :section_number, presence: true
  validates :class_number, presence: true
  validates :component, presence: true
  validates :term, presence: true
  validates :campus, presence: true

  serialize :section_attributes_json, JSON

end
