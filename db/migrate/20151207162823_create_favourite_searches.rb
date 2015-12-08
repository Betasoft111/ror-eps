class CreateFavouriteSearches < ActiveRecord::Migration
  def change
    create_table :favourite_searches do |t|
      t.string :skills
      t.string :qualification
      t.string :experience
      t.string :availability
      t.integer :user_id

      t.timestamps
    end
  end
end
