class AddPlanTypeToUsersPaymentHistories < ActiveRecord::Migration
  def change
    add_column :users_payment_histories, :plan_type, :string
    add_column :users_payment_histories, :plan_name, :string
  end
end
