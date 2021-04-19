class Venue < ApplicationRecord
  has_many :events

  validates_presence_of :name, :address, :city, :state, :zip
end
