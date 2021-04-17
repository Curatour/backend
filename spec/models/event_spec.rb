require 'rails_helper'

describe Event do
  describe 'relationships' do
    it { should belong_to :tour }
    it { should belong_to :venue }
    it { should have_many :sub_events }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :tour_id }
    it { should validate_presence_of :venue_id }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
  end
end
