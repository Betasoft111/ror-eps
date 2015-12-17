class AddUserEmailToToCompanyRequests < ActiveRecord::Migration
  def change
    add_column :company_requests, :user_emailTo, :string
  end
end
