class AddStaffPriceToCompanyStaffs < ActiveRecord::Migration
  def change
    add_column :company_staffs, :staff_price, :text
  end
end
