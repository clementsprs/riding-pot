require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fast_polylines'

class RidesController < ApplicationController

  def index
    # update_rides_status
    if params[:address].present?
      @rides = Ride.near(params[:address], 20).where(status: "upcoming")
      address_result = Geocoder.search(params[:address]).first.coordinates
      @search_address = [address_result[0], address_result[1]]
    else
      @rides = Ride.where(status: "upcoming")
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

  private

  def update_rides_status
    Ride.all.each do |ride|
      date_with_time = DateTime.new(
                          ride.date.year,
                          ride.date.month,
                          ride.date.day,
                          ride.starting_time.hour - 2,
                          ride.starting_time.min
                        )
      if date_with_time < DateTime.current
        ride.status = "done"
      else
        ride.status = "upcoming"
      end
      ride.save
    end
  end
end
