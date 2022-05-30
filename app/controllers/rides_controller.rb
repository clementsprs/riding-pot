class RidesController < ApplicationController
  def show
    @ride = Ride.find(params[:id])
  end

  def index
    @rides = Ride.all
  end
end
