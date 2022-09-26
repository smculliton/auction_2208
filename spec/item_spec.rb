require 'rspec'
require './lib/item'
require './lib/attendee'

RSpec.describe Item do 
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let(:attendee2) { attendee2 = Attendee.new({name: 'Bob', budget: '$75'}) }

  describe '#initialize' do 
    it 'exists' do 
      expect(item1).to be_a Item
    end
    it 'has a name' do 
      expect(item1.name).to eq('Chalkware Piggy Bank')
    end
    it 'starts with no bids' do 
      expect(item1.bids).to eq({})
    end
  end

  context 'bidding on items' do 
    it 'can add a bid' do 
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.bids).to eq({
                                 attendee2 => 20,
                                 attendee1 => 22
                               })
    end
    it 'can return current high bid' do 
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.current_high_bid).to eq(22)
    end
    it 'high bid is zero if no bids' do 
      expect(item1.current_high_bid).to eq(0)
    end
  end
end