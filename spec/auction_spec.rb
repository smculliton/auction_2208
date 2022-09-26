require 'rspec'
require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Auction do 
  let(:auction) { Auction.new }

  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') }
  let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
  let(:item4) { Item.new('2 Days Dogsitting') }
  let(:item5) { Item.new('Forever Stamps') }

  let(:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let(:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
  let(:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }

  describe '#initialize' do 
    it 'exists' do 
      expect(auction).to be_a Auction
    end
    it 'has no items' do 
      expect(auction.items).to eq([])
    end
  end

  context '#adding items' do 
    before(:each) do 
      auction.add_item(item1)
      auction.add_item(item2)
    end
    it 'can add items to items' do 
      expect(auction.items).to eq([item1, item2])
    end
    it 'can return names of items' do 
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  context 'bidding on items' do 
    before(:each) do 
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
    end
    it 'can return items with no bids' do 
      expect(auction.unpopular_items).to eq([item2, item3, item5])
      item3.add_bid(attendee2, 15)
      expect(auction.unpopular_items).to eq([item2, item5])
    end
    it 'can return total potential revenue' do 
      item3.add_bid(attendee2, 15)
      expect(auction.potential_revenue).to eq(87)
    end
  end
end
