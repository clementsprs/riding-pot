require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fast_polylines'

class RidesController < ApplicationController

  def index
    if params[:address].present?
      @rides = Ride.near(params[:address], 20)
      address_result = Geocoder.search(params[:address]).first.coordinates
      @search_address = [address_result[0], address_result[1]]
    else
      @rides = Ride.all
    end

    if @rides == []
      result = Geocoder.search(params[:address]).first.coordinates
      @markersIndex = [{
          lat: result[0],
          lng: result[1],
          image_url: helpers.asset_url("Map Marker - Riding Pot.png")
          }]
        else
          @markersIndex = @rides.geocoded.map do |ride|
            {
          lat: ride.latitude,
          lng: ride.longitude,
          image_url: helpers.asset_url("Map Marker - Riding Pot.png"),
          image_url_selected: helpers.asset_url("Map Marker Selected - Riding Pot.png"),
          info_window: render_to_string(partial: "info_window", locals: { ride: ride })
        }
      end
    end

  def show
    @ride = Ride.find(params[:id])
    # @markers = [lat: @ride.latitude, lng: @ride.longitude]
    @comment = Comment.new
    if params[:address].present?
      address_result = Geocoder.search(params[:address]).first.coordinates
      @search_address = [address_result[0], address_result[1]]
    end

    doc = Nokogiri::XML(@ride.gpx_file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    @markers = Array.new
    trackpoints.each do |trkpt|
      @markers << [
        trkpt.xpath('@lon').to_s.to_f, trkpt.xpath('@lat').to_s.to_f
      ]
    end
  end

end
