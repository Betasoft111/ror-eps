class CreateAdminSkills < ActiveRecord::Migration
  def change
    create_table :admin_skills do |t|
      t.string :skill

      t.timestamps
    end
  end
end
