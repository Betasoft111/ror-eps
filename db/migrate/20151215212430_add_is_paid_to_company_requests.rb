class AddIsPaidToCompanyRequests < ActiveRecord::Migration
  def change
    add_column :company_requests, :is_paid, :integer
  end
end
