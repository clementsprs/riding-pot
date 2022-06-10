class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @user = current_user
    @ride = Ride.find(params[:ride_id])
    @participation.user = @user
    @participation.ride = @ride
    if @participation.save
      redirect_to ride_path(@ride, confettis: true)
    else
      redirect_to ride_path(@ride), notice: @participation.errors.messages.first[1].first
    end
  end

  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy
    redirect_to ride_path(@ride)
  end
end
