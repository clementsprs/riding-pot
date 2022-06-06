class Comment < ApplicationRecord
  belongs_to :ride
  belongs_to :user
  validates :content, presence: true
end
