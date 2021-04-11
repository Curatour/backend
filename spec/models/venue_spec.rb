require 'rails_helper'

describe Venue do
  describe 'relationships' do
    it { should have_many :event_venues }
    it { should have_many(:events).through(:event_venues) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :capacity }
    it { should validate_numericality_of :capacity }
  end
end
