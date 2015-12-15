class AddRequestToToCompanyRequests < ActiveRecord::Migration
  def change
    add_column :company_requests, :request_to, :integer
  end
end
