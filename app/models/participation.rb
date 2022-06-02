class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :ride

  validates :user_id, uniqueness: { scope: :ride_id,
    message: "Vous ne pouvez vous inscrire qu'une seule fois" }
end
