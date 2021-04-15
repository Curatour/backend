class Tour < ApplicationRecord
  belongs_to :organization
  has_many :events
  
  validates_presence_of :name, :start_date, :end_date
end
