class Attendance < ApplicationRecord
  belongs_to :attendees, class_name: "User"
  belongs_to :events

  has_many :statuses

  enum :status, { pending: 0, accepted: 1, declined: 2}
end
