require 'rails_helper'

describe Tour do
  describe 'relationships' do
    it { should belong_to :organization }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end
end
