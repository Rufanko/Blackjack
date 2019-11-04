# frozen_string_literal: true

class Deck
  attr_reader :deck
  def initialize
    @deck = []
  end

  def new_deck
    Card::SUITS.each do |suit|
      Card::CARDS.each do |card|
        @deck << Card.new(card, suit)
      end
    end
    @deck.shuffle!
  end

  def pop_card
    raise 'Колода пустая' if @deck.empty?

    @deck.pop
  end
end
