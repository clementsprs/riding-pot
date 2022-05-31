class Ride < ApplicationRecord
  belongs_to :user
  has_many :participations
  geocoded_by :starting_point
  after_validation :geocode, if: :will_save_change_to_starting_point?
  validates :distance, :title, :date, :starting_time, :starting_point, :description, :elevation, :pace_min, :pace_max, :attendees_max, presence: true
end
