require 'rubygems'
require 'nokogiri'
require 'open-uri'


class RidesController < ApplicationController

  def show
    @ride = Ride.find(params[:id])
    # @markers = [lat: @ride.latitude, lng: @ride.longitude]

    doc = Nokogiri::XML(@ride.gpx_file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    @markers = Array.new
    trackpoints.each do |trkpt|
      @markers << [
        trkpt.xpath('@lon').to_s.to_f, trkpt.xpath('@lat').to_s.to_f
      ]
    end
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
