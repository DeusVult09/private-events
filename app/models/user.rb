class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :created_events, class_name: "Event", foreign_key: "creator_id", dependent: :destroy
  has_many :attendances, foreign_key: "attendee_id", dependent: :destroy
  has_many :attended_events, through: :attendance, source: :event
end
