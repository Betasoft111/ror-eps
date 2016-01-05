class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :message_to
      t.text :message_subject
      t.text :message_data

      t.timestamps
    end
  end
end
