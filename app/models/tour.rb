class Tour < ApplicationRecord
  belongs_to :organization

  validates_presence_of :name, :start_date, :end_date
end
