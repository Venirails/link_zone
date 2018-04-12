class RenameEventsWhenColumn < ActiveRecord::Migration
  def change
    rename_column :events, :when, :event_datetime
  end
end
