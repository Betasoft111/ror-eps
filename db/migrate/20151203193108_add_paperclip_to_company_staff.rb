class AddPaperclipToCompanyStaff < ActiveRecord::Migration
  add_attachment :company_staffs, :image
  def change
  end
end
