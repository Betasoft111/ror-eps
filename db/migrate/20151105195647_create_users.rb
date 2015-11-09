class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	
	  t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.integer :plan_id
      t.integer :user_type
      t.string :reset_password_token
      t.string :password_hash
      t.string :password_salt

      t.timestamps

      #ALTER TABLE users ADD CONSTRAINT fk_plan FOREIGN KEY (plan_id) REFERENCES subscription_plans (id)

    end
  end
end
