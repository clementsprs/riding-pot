class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :components ]

  def home
    @rides = Ride.all
  end

  def components
  end

end
