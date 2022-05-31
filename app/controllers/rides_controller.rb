# require 'rgeo/geo_json'

class RidesController < ApplicationController
  def show
    @ride = Ride.find(params[:id])


    # gpx_string = @ride.gpx_file
    # geom = RGeo::GeoJSON.decode(gpx_string)
    # @geom_final = geom.
  end

  def index
    @rides = Ride.all
  end
end

