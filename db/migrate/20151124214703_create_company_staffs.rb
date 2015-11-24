class CreateCompanyStaffs < ActiveRecord::Migration
  def change
    create_table :company_staffs do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :company_id
      t.string :skills
      t.string :availability
      t.boolean :is_private
      t.string :qualification
      t.string :experience

      t.timestamps
    end
  end
end
