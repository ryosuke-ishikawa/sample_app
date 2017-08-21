class AddOwnerToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :owner, :boolean, default: false
  end
end
