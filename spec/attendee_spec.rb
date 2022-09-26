require 'rspec'
require './lib/attendee'

RSpec.describe Attendee do
  let(:attendee) { Attendee.new({name: 'Megan', budget: '$50'}) }

  describe '#initialize' do 
    it 'exists' do 
      expect(attendee).to be_a Attendee
    end
    it 'has a name' do 
      expect(attendee.name).to eq('Megan')
    end
    it 'has a budget' do 
      expect(attendee.budget).to eq(50)
    end
  end
end