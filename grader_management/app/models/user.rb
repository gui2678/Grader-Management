class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validate :email_domain

  before_create :set_default_role

  def active_for_authentication?
    super && (approved? || role == 'student' || role == 'admin')
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  def effective_role
    approved? ? role : 'student'
  end

  private

  def email_domain
    domain = email.split('@').last
    errors.add(:email, 'must be an @osu.edu email') unless domain == 'osu.edu'
  end

  def set_default_role
    self.role = 'student' if self.role.blank?
    self.approved = true if self.role == 'student'
  end
end
