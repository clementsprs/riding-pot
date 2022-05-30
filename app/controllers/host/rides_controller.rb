class Host::RidesController < ApplicationController
  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @user = current_user
    @ride.user = @user
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
    params.require(:ride).permit(:distance, :title, :date, :starting_time, :starting_point, :description, :elevation, :pace_min, :pace_max, :attendees_max)
  end
end
