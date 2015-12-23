class AddPlanTypeToSubscriptionPlans < ActiveRecord::Migration
  def change
    add_column :subscription_plans, :plan_type, :integer
  end
end
