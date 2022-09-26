class Item 
  attr_reader :name, :bids, :item_winner

  def initialize(name)
    @name = name
    @bids = {}
    @closed = false
    @item_winner = 'Not Sold'
  end

  def add_bid(attendee, bid)
    return if closed? 

    bids[attendee] = bid
  end

  def current_high_bid
    bids.none? ? 0 : bids.values.max
  end

  def current_high_bidder
    bids.key(current_high_bid)
  end

  def close_bidding
    @item_winner = current_high_bidder unless bids.none?
    @closed = true
  end

  def closed?
    @closed 
  end

  def remove_highest_bid
    highest_bid = bids.key(bids.values.max)
    bids.delete(highest_bid)
  end
end