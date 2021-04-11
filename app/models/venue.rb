class Venue < ApplicationRecord
  has_many :event_venues
  has_many :events, through: :event_venues

  validates_presence_of :name, :address, :city, :state, :zip, :capacity
  validates_numericality_of :capacity
end
