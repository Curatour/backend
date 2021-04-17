class User < ApplicationRecord
  has_many :organizations

  validates_presence_of :first_name, :last_name, :email, :phone_number, :role

  validates_numericality_of :role

  enum role: [:admin, :member]
end
