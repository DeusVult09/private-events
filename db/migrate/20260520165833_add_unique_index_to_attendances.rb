class AddUniqueIndexToAttendances < ActiveRecord::Migration[8.1]
  def change
    add_index :attendances, [:attendee_id, :event_id], unique: true
  end
end
