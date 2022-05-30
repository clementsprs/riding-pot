class Ride < ApplicationRecord
  belongs_to :user
  has_many :participations
  has_one_attached :gpx_file
  validates :distance, :title, :date, :starting_time, :starting_point, :description, :elevation, :pace_min, :pace_max, :attendees_max, presence: true
end
