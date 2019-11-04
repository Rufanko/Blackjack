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
      ace_counter += 1 if y == 'Ace'
      @score += 10 if y == 'Queen'
      @score += 10 if y == 'Jack'
    end

    if ace_counter == 1
      if @score < 11
        @score += 11
      elsif score >= 11
        @score += 1
      end
   end

    if ace_counter == 2
      if @score <= 9
        @score += 12
      elsif @score > 9
        @score += 2
     end
    end

    @score += 13 if ace_counter == 3
   end
end
