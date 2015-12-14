class AddAvailabilityFromCompanyStaffs < ActiveRecord::Migration
  def change
    add_column :company_staffs, :availability_from, :string
  end
end
