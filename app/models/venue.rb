class Venue < ApplicationRecord
  has_many :events

  validates_presence_of :name, :address, :city, :state, :zip, :capacity
  validates_numericality_of :capacity
end
