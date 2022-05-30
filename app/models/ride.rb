class Ride < ApplicationRecord
  belongs_to :user
  has_many :participations
  validates :distance, :title, :date, :starting_time, :starting_point, :description, :elevation, :pace_min, :pace_max, :attendees_max, :gpx_file, presence: true
end
