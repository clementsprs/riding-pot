class Ride < ApplicationRecord
  belongs_to :user
  has_many :participations
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
        trkpt.xpath('@lon').to_s.to_f, trkpt.xpath('@lat').to_s.to_f
      ]
    end

    new_coords = []
    max_val = 23


    delta = (markers.length / max_val).to_i
    i = 0

    while i <= markers.length
      new_coords.push(markers[i].reverse)
      i += delta
    end
    FastPolylines.encode(new_coords)
  end

  def city
    results = Geocoder.search([latitude, longitude])
    return results.first.city
  end
end
