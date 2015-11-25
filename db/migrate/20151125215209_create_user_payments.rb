class CreateUserPayments < ActiveRecord::Migration
  def change
    create_table :user_payments do |t|
      t.string :payment_method
      t.string :payment_status
      t.string :user_id
      t.text :payment_json

      t.timestamps
    end
  end
end
