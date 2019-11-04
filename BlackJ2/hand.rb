# frozen_string_literal: true

class Hand
  attr_reader :score, :players_deck
  def initialize
    @players_deck = []
  end

  def show_cards; end

  def desolate
    @players_deck = []
  end

  def count
    ace_counter = 0
    @score = 0
    players_deck.each do |card|
      y = card.rank
      @score += y.to_i
      @score += 10 if y == 'King'
      ace_counter  if y == 'Ace'
      @score += 10 if y == 'Queen'
      @score += 10 if y == 'Jack'
    end
    @score += 11 if ace_counter == 1 && (21 - @score >= 11)
    @score += 12 if ace_counter == 2 && @score == 0
    @score += 13 if ace_counter == 3
   end
end
