# frozen_string_literal: true

require_relative 'bank.rb'
require_relative 'player.rb'
require_relative 'card.rb'
require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'interface'
require_relative 'validation'
class Game
  attr_reader :player, :bank, :interface, :deck, :dealer
  def initialize(interface)
    @bank = Bank.new
    @interface = interface
    name = @interface.greetings_text
    @player = Player.new(name)

    @dealer = Player.new('Dealer')
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
    @interface.player_cards(@player)
    @interface.new_round(@player)
  end

  def player_stop
    @player.hand.score > 21 || @player.hand.score == 21
  end

  def dealer_stop
    @dealer.hand.score > 17 && @player.hand.score < 21
  end

  def winner
    return 'dealer' if @player.hand.score > 21 || (@dealer.hand.score > @player.hand.score) && @dealer.hand.score < 21 || (@dealer.hand.score == 21 && @player.hand.score != 21)
    return 'player' if (@player.hand.score > @dealer.hand.score && @player.hand.score <= 21) || @player.hand.score <= 21 && @dealer.hand.score > 21
    return 'draw' if @player.hand.score == @dealer.hand.score
  end

  def players_turn
    loop do
      @player.hand.count
      @interface.player_score(@player)
      @interface.players_move_text
      uses_string = gets.chomp!
      case uses_string
      when '1'

        @player.take(@deck)
        @interface.player_cards(@player)
        card_counter = 3
        break if player_stop

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

    puts 'Дилер ходит...'
    loop do
      card_counter = 3
      break if dealer_stop

      @dealer.take(@deck)
      @dealer&.hand.count

      puts '***'
      puts @dealer.hand.score
      break if card_counter == 3
    end
  end

  def winner_message
    case winner
    when 'dealer'
      puts 'Вы проиграли. Деньги уходят дилеру.'
      puts "Количество очков дилера #{@dealer.hand.score}"
      puts 'Карты дилера'
      @interface.player_cards(@dealer)
      @bank.give_money_dealer
    when 'player'
      puts 'Вы выиграли! Поздравляем!'
      @bank.give_money_player
    when 'draw'
      puts 'Ничья...'
      @bank.draw
    end
  end

  def play_again
    @interface.another_game_text(@bank)
    return false if @bank.enough_money

    loop do
      puts "Сыграем еще?\n1.Да\n2.Нет"
      uses_string = gets.chomp
      case uses_string
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
