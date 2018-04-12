class AddChatStatus < ActiveRecord::Migration
  def change
  	add_column :messages, :read_status, :boolean
  end
end
