class ChangeDataTypeInCompanyStaffs < ActiveRecord::Migration
  def change

  	change_column :company_staffs, :staff_price, :text
  end
end
