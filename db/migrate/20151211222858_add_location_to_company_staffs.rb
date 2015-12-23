class AddLocationToCompanyStaffs < ActiveRecord::Migration
  def change
    add_column :company_staffs, :location, :string
  end
end
