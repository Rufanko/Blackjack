# frozen_string_literal: true

require_relative 'bank.rb'
require_relative 'player.rb'
require_relative 'card.rb'
require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'interface'
require_relative 'validation'
require_relative 'dealer'
class Game
  attr_reader :player, :bank, :interface, :deck, :dealer
  def initialize(interface)
    @bank = Bank.new
    @interface = interface
    name = @interface.greetings_text
    @player = Player.new(name)

    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
  end

  def run
    system('clear')
    @interface.greetings_text2(@player)
    loop do
      new_round
      break unless play_again
    end
    @interface.u_lost_text(@bank)
  end

  def new_round
    start_game
    players_turn
    dealers_turn
    winner_message
  end

  def start_game
    @bank.bet_money
    @deck.new_deck
    @player.hand.desolate
    @dealer.hand.desolate
    2.times { @player.take(@deck) }
    2.times { @dealer.take(@deck) }
    # @interface.player_cards(@player)
    @interface.new_round(@player)
  end

  def player_stop
    @player.hand.score > 21 || @player.hand.score == 21
  end

  def dealer_stop
    @dealer.hand.score > 17 && @player.hand.score < 21
  end

  def player_overflowed
    @player.hand.score > 21
  end

  def dealer_overflowed
    @dealer.hand.score > 21
  end

  def dealer_has_higher_score
    @dealer.hand.score > @player.hand.score
  end

  def player_has_higher_score
    @player.hand.score > @dealer.hand.score
  end

  def equal_scores
    @player.hand.score == @dealer.hand.score
  end

  def black_jack(player)
    player.hand.score == 21
  end

  def winner
    return 'dealer' if player_overflowed || (dealer_has_higher_score && !dealer_overflowed) || (black_jack(@dealer) && !black_jack(@player))
    return 'player' if player_has_higher_score || (player_has_higher_score && player_overflowed && dealer_overflowed) || !player_overflowed && dealer_overflowed || black_jack(@player)
    return 'draw' if equal_scores
  end

  def players_turn
    loop do
      @player.hand.count
      @interface.player_score(@player)
      case @interface.players_move_text

      when '1'

        @player.take(@deck)
        @interface.player_cards(@player)
        card_counter = 3
        @player.hand.count
        @interface.count(@player)

        break
      when '2'
        break

      end
      @player.hand.players_deck
      @player.hand.score
      @bank.player_bank
    end
  end

  def dealers_turn
    @dealer&.hand.count

    loop do
      @interface.dealers_move
      break unless @dealer.should_take?
      break if player_overflowed

      card_counter = 3

      @dealer.take(@deck)
      @dealer&.hand.count
      break if card_counter == 3
    end
  end

  def winner_message
    case winner
    when 'dealer'
      @interface.winner_dealer(@dealer, @bank)

    when 'player'
      @interface.winner_player(@dealer, @bank)

    when 'draw'
      @interface.draw(@dealer, @bank)
    end
  end

  def open_cards
    @interface.player_cards(@player)
    @interface.player_cards(@dealer)
    @interface.player_score(@player)
    @interface.dealer_score(@dealer)
  end

  def play_again
    @interface.another_game_text(@bank)
    return false if @bank.enough_money

    loop do
      case @interface.another_game
      when '1'
        return true
        break
      when '2'
        return false
        break
      end
    end
end
end
