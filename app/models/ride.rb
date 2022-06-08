require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fast_polylines'

class Ride < ApplicationRecord
  belongs_to :user
  has_many :participations
  has_many :comments
  geocoded_by :starting_point
  after_validation :geocode, if: :will_save_change_to_starting_point?
  validates :distance_ride, :title, :date, :starting_point, :description, :elevation, :pace_min, :pace_max, :attendees_max, presence: true
  CITIES = ["Nantes", "Paris", "Marseille", "Lille", "Bordeaux", "Rennes"]

  def mapbox_path
    doc = Nokogiri::XML(gpx_file)
    trackpoints = doc.xpath('//xmlns:trkpt')

    markers = Array.new

    trackpoints.each do |trkpt|
      markers << [
        trkpt.xpath('@lon').to_s.to_f.truncate(5), trkpt.xpath('@lat').to_s.to_f.truncate(5)
      ]
    end

    new_coords = []
    max_val = 97

    delta = (markers.length / max_val)
    i = 0
    while new_coords.length < max_val
      new_coords.push(markers[i].reverse)
      i += delta
    end
    result = FastPolylines.encode(new_coords).to_query("")[1..-1]
  end


  def city
    results = Geocoder.search([latitude, longitude])
    return results.first.city
  end

  # def status!
  #   date_with_time = DateTime.new(date.year, date.month, date.day, starting_time.hour - 2, starting_time.min)
  #   if date_with_time < DateTime.current
  #     status = "done"
  #   else
  #     status = "upcoming"
  #   end
  # end
end
