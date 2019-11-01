# frozen_string_literal: true

class Bank
  attr_reader :player_bank, :dealer_bank, :bet
  def initialize(player_bank = 100, dealer_bank = 100, bet = 10)
    @player_bank = player_bank
    @dealer_bank = dealer_bank
    @bet = bet
    validate!
  end

  def bet_money
    @player_bank -= @bet
    @dealer_bank -= @bet
  end

  def give_money_player
    @player_bank += @bet * 2
  end

  def give_money_dealer
    @dealer_bank += @bet * 2
  end

  def enough_money
    if @player_bank >= @bet && @dealer_bank >= @bet
end
end

  def draw
    @player_bank += @bet
    @dealer_bank += @bet
  end

  def validate!
    raise 'недостаточно средств' if @player_bank < @bet || @dealer_bank < @bet
  end
end
