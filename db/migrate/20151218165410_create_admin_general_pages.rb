class CreateAdminGeneralPages < ActiveRecord::Migration
  def change
    create_table :admin_general_pages do |t|
      t.string :page_name
      t.string :page_title
      t.text :page_content

      t.timestamps
    end
  end
end
