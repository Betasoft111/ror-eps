class CreateAdminHelpCenters < ActiveRecord::Migration
  def change
    create_table :admin_help_centers do |t|
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
