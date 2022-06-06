class Host::RidesController < ApplicationController
  def new
    @ride = Ride.new
    @routes = get_routes()
  end

  def create
    @ride = Ride.new(ride_params)
    client = Strava::Api::Client.new(
      access_token: "d1d9cda844f505ba0951bcaf1a58c52076cbec43"
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
    raise
    if @ride.save
      redirect_to ride_path(@ride)
    else
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
      access_token: "d1d9cda844f505ba0951bcaf1a58c52076cbec43"
    )
    routes = client.athlete_routes(client.athlete.id) # => Array[Strava::Models::Route]
    routes_rides = routes.select do |route|
      route.type == 1
    end
    routes_rides.map do |route|
      {id: route.id, name: route.name}
    end
  end
end
