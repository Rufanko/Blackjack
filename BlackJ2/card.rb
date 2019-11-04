# frozen_string_literal: true

class Card
  CARDS = [3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'].freeze
  SUITS = ['♠', '♣', '♥', '♦'].freeze
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end
