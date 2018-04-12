class AddReadStatus < ActiveRecord::Migration
  def change
  	add_column :activities,:read_status,:boolean
  end
end
