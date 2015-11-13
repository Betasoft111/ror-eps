class CreateAdminAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_admin_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :reset_password_token
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
