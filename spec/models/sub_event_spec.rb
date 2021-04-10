require 'rails_helper'

describe SubEvent do
  describe 'relationships' do
    it { should belong_to :event }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :event_id }
  end
end
