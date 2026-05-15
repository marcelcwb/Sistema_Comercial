class AddRoleToUsers < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :role, :string, null: false, default: "operational" unless column_exists?(:users, :role)

    if column_exists?(:users, :admin)
      execute "UPDATE users SET role = 'administrator' WHERE admin = 1"
    end
  end

  def down
    remove_column :users, :role if column_exists?(:users, :role)
  end
end
