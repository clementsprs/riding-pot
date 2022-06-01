require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fast_polylines'


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
    @markersIndex = @rides.geocoded.map do |ride|
      {
        lat: ride.latitude,
        lng: ride.longitude
      }
    end
    @rides.each do |ride|
    doc = Nokogiri::XML(ride.gpx_file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    @markers = Array.new
    trackpoints.each do |trkpt|
      @markers << [
        trkpt.xpath('@lon').to_s.to_f, trkpt.xpath('@lat').to_s.to_f
      ]
    end
  end
  @rides.each do |ride|
    doc = Nokogiri::XML(ride.gpx_file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    @markers = Array.new
    trackpoints.each do |trkpt|
      @markers << [
        trkpt.xpath('@lat').to_s.to_f, trkpt.xpath('@lon').to_s.to_f
      ]
    end
  end
  newCoords = []
  maxVal = 97
  delta = (@markers.length / maxVal ).floor
  i = 0
  while i < @markers.length
    newCoords.push(@markers[i])
    i += delta
  end
  @path = FastPolylines.encode(newCoords)

  end
end
