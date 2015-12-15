class AddRequestByToCompanyRequests < ActiveRecord::Migration
  def change
    add_column :company_requests, :request_by, :integer
  end
end
