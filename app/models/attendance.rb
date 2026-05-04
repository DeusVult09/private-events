class Attendance < ApplicationRecord
  belongs_to :attendees, class_name: "User"
  belongs_to :events
end
