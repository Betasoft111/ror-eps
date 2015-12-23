class CreateAdminQualifications < ActiveRecord::Migration
  def change
    create_table :admin_qualifications do |t|
      t.string :qualification

      t.timestamps
    end
  end
end
