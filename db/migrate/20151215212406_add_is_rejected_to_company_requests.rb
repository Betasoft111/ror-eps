class AddIsRejectedToCompanyRequests < ActiveRecord::Migration
  def change
    add_column :company_requests, :is_rejected, :integer
  end
end
