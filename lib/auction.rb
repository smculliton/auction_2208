require 'date'

class Auction
  attr_reader :items 

  def initialize
    @items = []
  end

  def date
    Date.today.strftime("%d/%m/%Y")
  end

  def add_item(item)
    items << item
  end

  def item_names
    items.map { |item| item.name }
  end

  def unpopular_items
    items.select { |item| item.bids.none? }
  end

  def potential_revenue
    items.sum { |item| item.current_high_bid }
  end 

  def bidders
    attendees_with_bids.map { |attendee| attendee.name }
  end

  def attendees_with_bids
    items.map { |item| item.bids.keys }.flatten.uniq
  end

  def bidder_info
    hash = {}
    attendees_with_bids.each do |attendee|
      hash[attendee] = attendee_info(attendee)
    end
    hash
  end

  def attendee_info(attendee)
    items_bid_on = items.select { |item| item.bids.keys.include?(attendee) }
    { budget: attendee.budget, items: items_bid_on }
  end

  def close_auction 
    close_items_without_bids
    sell_items_with_bids

    hash = {}
    items.each do |item|
      hash[item] = item.item_winner
    end
    hash
  end

  def close_items_without_bids
    items.each { |item| item.close_bidding if item.bids.none? }
  end

  def sell_items_with_bids
    until items.all?(&:closed?) 
      attendees_with_bids.each { |attendee| item_seller(attendee) }
      close_items_without_bids
    end
  end

  def item_seller(attendee)
    winning_bids(attendee).each do |item|
      if can_afford_item?(attendee, item)
        item.close_bidding
        attendee.spend_budget(item.current_high_bid)
      else
        item.remove_highest_bid
      end
    end
  end

  def winning_bids(attendee)
    bids = items.select { |item| item.current_high_bidder == attendee }
    bids.sort_by { |item| 0 - item.current_high_bid }
  end

  def can_afford_item?(attendee, item)
    attendee.budget > item.current_high_bid
  end
end