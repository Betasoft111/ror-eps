class AddTotalProfilesToSubscriptionPlans < ActiveRecord::Migration
  def change
    add_column :subscription_plans, :total_profiles, :integer
  end
end
