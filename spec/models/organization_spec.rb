require 'rails_helper'

describe Organization do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :tours }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user_id }
  end
end
