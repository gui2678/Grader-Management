class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :sections, foreign_key: 'instructor_id'
  has_many :enrollments, foreign_key: 'student_id'
  has_many :approvals

  # Define user roles
  enum role: {student: 'student', instructor: 'instructor', admin: 'admin'}

  # Validations
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validate :email_domain

  
  private

  def email_domain
    domain = email.split('@').last
    errors.add(:email, 'must be an @osu.edu email') unless domain == 'osu.edu'
  end
  
end
