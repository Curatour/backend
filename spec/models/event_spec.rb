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

    it 'is invalid when end_time is before start_time' do
      user = create(:user)
      org = create(:organization, user_id: user.id)
      venue = create(:venue)
      tour = create(:tour, organization: org)
      
      expect do
        create(
          :event,
            tour: tour,
            venue: venue,
            start_time: "2021-04-20T20:44:46Z",
            end_time: '2021-04-20T20:00:00Z'
        )
      end.to raise_error
    end
  end
end
