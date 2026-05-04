class CreateAttendaces < ActiveRecord::Migration[8.1]
  def change
    create_table :attendaces do |t|
      t.references :attendee, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
