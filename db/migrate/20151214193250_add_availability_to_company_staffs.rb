class AddAvailabilityToCompanyStaffs < ActiveRecord::Migration
  def change
    add_column :company_staffs, :availability_to, :string
  end
end
