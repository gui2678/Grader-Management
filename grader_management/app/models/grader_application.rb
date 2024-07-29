class GraderApplication < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :section

  validates :display_name, :first_name, :middle_name, :last_name, :legal_last_name,
            :username, :email, :address, :phone, presence: true

  def full_name
    [first_name, middle_name, last_name, name_suffix].reject(&:blank?).join(' ')
  end
end