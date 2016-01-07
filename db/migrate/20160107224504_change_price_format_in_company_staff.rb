class ChangePriceFormatInCompanyStaff < ActiveRecord::Migration
  def change
  	change_column :company_staffs, :staff_price, :integer
  end
end
