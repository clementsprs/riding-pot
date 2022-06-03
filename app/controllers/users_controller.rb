require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fast_polylines'

class UsersController < ApplicationController

  def dashboard
    participations = Ride.joins(:participations).where(participations: { user: current_user })
    rides = Ride.where(user: current_user)

    case params[:choice]
    when 'past_rides'
      # raise
      @participations = participations.where(status: 'done')
      @rides = rides.where(status: 'done')
    when 'upcoming_rides'
      @rides = rides.where(status: 'upcoming')
      @participations = participations.where(status: 'upcoming')
    end

  end

end
