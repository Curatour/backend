require 'rails_helper'

describe Tour do
  describe 'relationships' do
    it { should belong_to :organization }
    it { should have_many :events }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }

    it 'is valid when end_date is on_or_after start_date' do
      user = create(:user)
      org = create(:organization, user_id: user.id)
      
      expect do
        create(
          :tour,
            organization: org,
            start_date: "2021-04-20",
            end_date: '2021-04-20'
        )
      end.to_not raise_error ActiveRecord::RecordInvalid
    end
    
    it 'is invalid when end_date is before start_date' do
      user = create(:user)
      org = create(:organization, user_id: user.id)
      
      expect do
        create(
          :tour,
            organization: org,
            start_date: "2021-04-20",
            end_date: '2021-04-19'
        )
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
