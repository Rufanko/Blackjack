# frozen_string_literal: true

require_relative 'validation'
class Player
  attr_reader :name, :hand

  include Validation
  NAME_FORMAT = /^([a-zA-Z]){2,12}$/.freeze
  validate :name, :format, NAME_FORMAT
  def initialize(name)
    @name = name
    @hand = Hand.new
    validate!
  end

  def take(deck)
    @hand.players_deck << deck.pop_card
  end
end
