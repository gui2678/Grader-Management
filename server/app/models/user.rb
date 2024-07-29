class User < ApplicationRecord
  enum role: { student: 0, instructor: 1, admin: 2 }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validate :password_different_from_old, if: :will_save_change_to_encrypted_password?

  def has_permission?(permission)
    role_permissions = {
      student: ['browse_catalog'],
      instructor: ['browse_catalog'],
      admin: ['browse_catalog', 'edit_catalog', 'reload_catalog', 'approve_registers']
    }
    role_permissions[role.to_sym].include?(permission)
  end

  private

  def password_different_from_old
    if Devise::Encryptor.compare(self.class, encrypted_password_was, password)
      errors.add(:password, 'must be different from the old password')
    end
  end
end
