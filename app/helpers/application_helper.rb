module ApplicationHelper

  def ride_status_text(status)
    if status == "past_rides"
      "Mes sorties précédentes"
    else
      "Mes sorties à venir"
    end
  end

  def ride_status_css(status)
    if status == "past_rides"
      "0.2"
    elsif status == "upcoming_rides"
      "0"
    end
  end
end
