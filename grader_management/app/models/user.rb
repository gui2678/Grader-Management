class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :sections, foreign_key: 'instructor_id'
  has_many :enrollments, foreign_key: 'student_id'
  has_many :approvals
  has_many :grader_applications
  has_many :availabilities

  # Define user roles
  enum role: { student: 'student', instructor: 'instructor', admin: 'admin' }

  # Validations
  validates :email, presence: true, format: { with: /\A[a-zA-Z0-9._%+-]+\.\d+@osu\.edu\z/, message: 'must be in the format name.#@osu.edu' }
  validates :password, presence: true, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  before_create :set_default_role

  def active_for_authentication?
    super && (approved? || role == 'student' || role == 'instructor' || role == 'admin')
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  def effective_role
    approved? ? role : 'student'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_role
    self.role = 'student' if self.role.blank?
    self.approved = true if self.role == 'student'
  end
end
