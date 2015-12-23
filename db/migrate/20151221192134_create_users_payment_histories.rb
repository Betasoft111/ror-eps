class CreateUsersPaymentHistories < ActiveRecord::Migration
  def change
    create_table :users_payment_histories do |t|
      t.integer :plan_id
      t.integer :user_id
      t.datetime :purchased_on
      t.datetime :expired_on

      t.timestamps
    end
  end
end
