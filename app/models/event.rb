class Event < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 50 }
  validates :location, presence: true
  validates :date, presence: true

  belongs_to :creator, class_name: "User"

  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :attendee

  scope :upcoming, -> { where("date >= ?", Time.current) }
  scope :past, -> { where("date < ?", Time.current) }
end
