class CreateAdminStaffPlans < ActiveRecord::Migration
  def change
    create_table :admin_staff_plans do |t|
      t.string :plan_name
      t.integer :no_of_staff
      t.integer :plan_price

      t.timestamps
    end
  end
end
