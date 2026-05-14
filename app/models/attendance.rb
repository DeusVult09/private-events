class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :event

  has_many :statuses

  enum :status, { pending: 0, accepted: 1, declined: 2 }
end
