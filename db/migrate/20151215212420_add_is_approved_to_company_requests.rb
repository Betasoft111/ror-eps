class AddIsApprovedToCompanyRequests < ActiveRecord::Migration
  def change
    add_column :company_requests, :is_approved, :integer
  end
end
