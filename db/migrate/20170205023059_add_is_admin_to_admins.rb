class AddIsAdminToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :is_admin, :boolean
  end
end
