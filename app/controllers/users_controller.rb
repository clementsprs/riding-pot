class UsersController < ApplicationController

  def dashboard
    participations = Ride.joins(:participations).where(participation: { user: current_user })
    rides = Ride.where(user: current_user)

    case params[:choice]
    when 'past_participations'
      @past_participations = participations.where(status: 'done')
    when 'upcoming_participations'
      @upcoming_rides = rides.where(status: 'upcoming')
    when 'past_rides'
      @past_rides = rides.where(status: 'done')
    when '' || 'upcoming_rides'
      @upcoming_participations = participations.where(status: 'upcoming')
    end

  end

end
