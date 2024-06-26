class User < ApplicationRecord
  enum role: { student: 0, instructor: 1, admin: 2 }

  def has_permission?(permission)
    role_permissions = {
      student: ['browse_catalog'],
      instructor: ['browse_catalog'],
      admin: ['browse_catalog', 'edit_catalog', 'reload_catalog', 'approve_registers']
    }
    role_permissions[role.to_sym].include?(permission)
  end
end
