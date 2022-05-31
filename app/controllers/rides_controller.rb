require 'nokogiri'
require 'open-uri'


class RidesController < ApplicationController

  def show
    @ride = Ride.find(params[:id])
    @markers = [lat: @ride.latitude, lng: @ride.longitude]


    # file = File.open("geom")
    # doc = Nokogiri::XML(file)
    # trackpoints = doc.xpath('trkpt')
    # route = []
    # @markers = trackpoints.each do |trkpt|
    #   lat = trkpt.xpath('@lat').to_s.to_f
    #   lon = trkpt.xpath('@lon').to_s.to_f
    #   ele = trkpt.text.strip.to_f
    #   route << { lat: lat, lon: lon, ele: ele }
    # end
  end

  def index
    @rides = Ride.all
    @markers = @rides.geocoded.map do |ride|
      {
        lat: ride.latitude,
        lng: ride.longitude
      }
    end
  end

end
