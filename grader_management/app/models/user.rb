class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :sections, foreign_key: 'instructor_id'
  has_many :enrollments, foreign_key: 'student_id'
  has_many :approvals

  #Define user roles
  enum role: {student: 'student', instructor:'instructor', admin:'admin'}

  # Validations
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
end
