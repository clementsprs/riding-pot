class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @user = current_user
    @ride = Ride.find(params[:id])
    @participation.user = @user
    @participation.ride = @ride
    @participation.save
    redirect_to ride_path(@ride)
  end

  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy
    redirect_to ride_path(@ride)
  end
end
