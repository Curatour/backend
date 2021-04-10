require 'rails_helper'

describe User do
  describe 'relationships' do
    it { should have_many :organizations }
  end

  describe 'validations' do
    it { should validate_presence_of :firstName }
    it { should validate_presence_of :lastName }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :role }
  end
end
