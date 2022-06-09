require "open-uri"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :participations
  has_many :rides
  has_many :comments
  before_save :assign_photo
  validates :first_name, :last_name, :username, presence: true

  private

  def assign_photo
    return if photo.attached?

    photoavatar = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1654783466/avatar_cwi0wm.jpg')
    photo.attach(io: photoavatar, filename: 'avatar.png', content_type: 'image/png')
  end
end
