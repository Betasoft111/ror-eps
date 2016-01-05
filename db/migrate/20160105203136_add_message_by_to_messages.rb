class AddMessageByToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :message_by, :integer
  end
end
