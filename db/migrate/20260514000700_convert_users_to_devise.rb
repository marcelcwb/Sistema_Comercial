class ConvertUsersToDevise < ActiveRecord::Migration[7.2]
  def up
    return unless table_exists?(:users)

    rename_column :users, :password_digest, :encrypted_password if column_exists?(:users, :password_digest)
    change_column_default :users, :encrypted_password, "" if column_exists?(:users, :encrypted_password)

    add_column :users, :reset_password_token, :string unless column_exists?(:users, :reset_password_token)
    add_column :users, :reset_password_sent_at, :datetime unless column_exists?(:users, :reset_password_sent_at)
    add_column :users, :remember_created_at, :datetime unless column_exists?(:users, :remember_created_at)

    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end

  def down
    remove_index :users, :reset_password_token if table_exists?(:users) && index_exists?(:users, :reset_password_token)
    remove_column :users, :remember_created_at if table_exists?(:users) && column_exists?(:users, :remember_created_at)
    remove_column :users, :reset_password_sent_at if table_exists?(:users) && column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :reset_password_token if table_exists?(:users) && column_exists?(:users, :reset_password_token)
    rename_column :users, :encrypted_password, :password_digest if table_exists?(:users) && column_exists?(:users, :encrypted_password)
  end
end
