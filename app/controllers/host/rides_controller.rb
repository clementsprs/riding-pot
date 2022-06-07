require 'rubygems'
require 'nokogiri'
require 'fast_polylines'


class Host::RidesController < ApplicationController
  def new
    @ride = Ride.new
    @routes = get_routes()
  end

  def create
    @ride = Ride.new(ride_params)
    client = Strava::Api::Client.new(
      access_token: current_user.access_token
    )
    routes = client.athlete_routes(client.athlete.id) # => Array[Strava::Models::Route]
    all_routes = routes.map do |route|
      {id: route.id, name: route.name}
    end
    route = all_routes.find{|route| route[:name] == @ride.route_name}[:id]
    data = client.export_route_gpx(route) # => String
    @user = current_user
    @ride.user = @user
    @ride.gpx_file = data
    doc = Nokogiri::XML(@ride.gpx_file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    @markers = Array.new
    trackpoints.each do |trkpt|
      @markers << [
        trkpt.xpath('@lon').to_s.to_f, trkpt.xpath('@lat').to_s.to_f
      ]
    end
    results = Geocoder.search(@markers[0].reverse)
    @ride.starting_point = results.first.address
    @coordinates = Array.new
    trackpoints.each do |trkpt|
      @coordinates << [
        trkpt.xpath('@lat').to_s.to_f, trkpt.xpath('@lon').to_s.to_f
      ]
    end
    @ride.distance_ride = get_distance(@coordinates)
    @ride.elevation = get_elevation(@ride.gpx_file)
    if @ride.save!
      redirect_to ride_path(@ride)
    else
      @routes = get_routes()
      render :new
    end
  end

  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy
    redirect_to rides_path
  end

  def edit
    @ride = Ride.find(params[:id])
  end

  def update
    @ride = Ride.find(params[:id])
    @ride.update(ride_params)
    redirect_to ride_path(@ride)
  end

  private

  def ride_params
    params.require(:ride).permit(:distance_ride, :title, :date, :route_name, :starting_time, :starting_point, :description, :elevation, :pace_min, :pace_max, :attendees_max)
  end

  def get_routes()
    client = Strava::Api::Client.new(
      access_token: current_user.access_token
    )
    routes = client.athlete_routes(client.athlete.id) # => Array[Strava::Models::Route]
    routes_rides = routes.select do |route|
      route.type == 1
    end
    routes_rides.map do |route|
      {id: route.id, name: route.name}
    end
  end

  def get_elevation(data)
    doc = Nokogiri::XML(data)
    trackpoints = doc.xpath('//xmlns:trkpt')
    @markers = Array.new
    trackpoints.each do |trkpt|
      @markers << trkpt.text.strip.to_f
    end
    @sum = 0
    @markers.each_with_index {|elevation_point, index|
      next_element = @markers[index + 1]
      @sum += (next_element - elevation_point) if !next_element.nil? &&  next_element > elevation_point
    }
    @sum
  end

  def get_distance(markers)
    @sum = 0
    markers.each_with_index {|coordinate, index|
      next_element = markers[index + 1]
      @sum += Geocoder::Calculations.distance_between(coordinate, next_element) unless next_element.nil?
    }
    @sum.to_i
  end
end
