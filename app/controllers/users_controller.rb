require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fast_polylines'

class UsersController < ApplicationController

  def dashboard
    participations = Ride.joins(:participations).where(participation: { user: current_user })
    rides = Ride.where(user: current_user)

    case params[:choice]
    when 'past_rides'
      @past_participations = participations.where(status: 'done')
      @past_rides = rides.where(status: 'done')
    when 'upcoming_rides'
      @upcoming_rides = rides.where(status: 'upcoming')
      @upcoming_participations = participations.where(status: 'upcoming')
    end

  end

end
