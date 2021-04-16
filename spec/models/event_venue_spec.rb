require 'rails_helper'

describe EventVenue do
  describe 'relationships' do
    it { should belong_to :event }
    it { should belong_to :venue }
  end

  describe 'validations' do
    it { should validate_presence_of :event_id }
    it { should validate_presence_of :venue_id }
  end
end
