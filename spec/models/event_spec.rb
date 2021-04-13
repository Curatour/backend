require 'rails_helper'

describe Event do
  describe 'relationships' do
    it { should belong_to :tour }
    it { should have_many :sub_events }
    it { should have_many :event_venues }
    it { should have_many(:venues).through(:event_venues) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :tour_id }
    it { should validate_presence_of :venue_id }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
  end
end
