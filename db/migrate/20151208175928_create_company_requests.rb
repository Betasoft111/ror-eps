class CreateCompanyRequests < ActiveRecord::Migration
  def change
    create_table :company_requests do |t|
      t.string :name
      t.integer :amount
      t.integer :total_emp
      t.integer :selected_emp
      t.integer :total_days
      t.text :additional

      t.timestamps
    end
  end
end
