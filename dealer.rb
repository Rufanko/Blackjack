# frozen_string_literal: true

class Dealer < Player
  def initialize(name)
    @name = name
    @hand = Hand.new
    # validate!
  end

  def should_take? # (dealer)
    hand.score < 17
  end
end
