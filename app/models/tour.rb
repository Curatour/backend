class Tour < ApplicationRecord
  belongs_to :organization
  has_many :events
  
  validates_presence_of :name, :start_date, :end_date
  validates_datetime :end_date, on_or_after: :start_date
end
