class AddUserEmailByToCompanyRequests < ActiveRecord::Migration
  def change
    add_column :company_requests, :user_emailBy, :string
  end
end
