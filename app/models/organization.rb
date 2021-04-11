class Organization < ApplicationRecord
  belongs_to :user
  has_many :tours

  validates_presence_of :name, :user_id

end
