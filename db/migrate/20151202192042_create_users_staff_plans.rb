class CreateUsersStaffPlans < ActiveRecord::Migration
  def change
    create_table :users_staff_plans do |t|
      t.integer :user_id
      t.integer :plan_id

      t.timestamps
    end
  end
end
