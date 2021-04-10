class User < ApplicationRecord
  has_many :organizations

  validates_presence_of :firstName, :lastName, :email, :phone_number, :role

  validates_numericality_of :role

  enum role: [:admin, :member]
end
