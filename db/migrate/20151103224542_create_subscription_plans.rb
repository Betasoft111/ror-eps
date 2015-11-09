class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.string :plan_name
      t.string :plan_name
      t.string :plan_price

      t.timestamps
    end
  end
end
