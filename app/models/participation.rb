class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :ride

  validates :user_id, uniqueness: { scope: :ride_id,
    message: "Vous ne pouvez vous inscrire qu'une seule fois" }

  after_create :incremante_ride_participants

  private

  def incremante_ride_participants
    ride.update!(participants: ride.participants += 1)
  end
end
