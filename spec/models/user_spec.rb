require 'rails_helper'

describe User do
  describe 'relationships' do
    it { should have_many :organizations }
    it { should have_many :contacts }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :role }
  end
end
