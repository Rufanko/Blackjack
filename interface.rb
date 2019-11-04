# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'bank.rb'
require_relative 'player.rb'
require_relative 'card.rb'
require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'interface'
class Interface
  def greetings_text
    puts 'Здравствуйте, уважаемый игрок'
    puts 'Введите Ваше имя'
    name = gets.chomp!
  end

  def draw(dealer, bank)
    puts 'Ничья...'
    puts "Количество очков дилера #{dealer.hand.score}"
    puts 'Карты дилера'
    player_cards(dealer)
    bank.draw
  end

  def winner_dealer(dealer, bank)
    puts 'Вы проиграли. Деньги уходят дилеру.'
    puts "Количество очков дилера #{dealer.hand.score}"
    puts 'Карты дилера'
    player_cards(dealer)
    bank.give_money_dealer
  end

  def winner_player(dealer, bank)
    puts 'Вы выиграли! Поздравляем!'
    puts "Количество очков дилера #{dealer.hand.score}"
    puts 'карты дилера'
    # dealer.hand.players_deck.each { |x| print "#{x.rank} #{x.suit}\n" })
    player_cards(dealer)
    bank.give_money_player
  end

  def greetings_text2(player)
    puts "#{player.name}, игра начинается"
  end

  def choice_text
    puts 'Для того, чтобы начать игру, нажмите 1'
    puts 'Для того, чтобы уйти, нажмите 2'
  end

  def u_lost_text(bank)
    puts "Вы проиграли. На счету осталось #{bank.player_bank}$"
  end

  def count(player)
    puts " У вас #{player.hand.score} очков "
  end

  def players_move_text
    puts '1.Взять карту'
    puts '2.Пропустить ход'
    uses_string = gets.chomp!
  end

  def dealer_win_text(bank)
    puts "Выиграл дилер. на вашем счету осталось #{bank.player_bank}"
  end

  def draw_text
    puts 'Ничья...'
  end

  def another_game
    puts "Сыграем еще?\n1.Да\n2.Нет"
    uses_string = gets.chomp
   end

  def dealers_move
    puts 'Дилер ходит...'
    puts 'Карты дилера ***'
  end

  def another_game_text(bank)
    puts "На Вашем счету осталось #{bank.player_bank}$, хотите сыграть еще?"
      # puts "1.Да\n2.Нет"
      # gets.to_i
    end

  def player_cards(player)
    # puts 'Ваши карты:'
    player.hand.players_deck.each { |x| print "#{x.rank} #{x.suit}\n" }
  end

  def new_round(player)
    puts 'Мешаем карты...'
    puts 'Раздаем...'
    puts 'Ваши карты:'
    player.hand.players_deck.each { |x| print "#{x.rank} #{x.suit}\n" }
    puts 'Карты дилера * *'
  end

  def player_score(player)
    puts "У вас #{player.hand.score} очков"
  end

  def dealer_score(dealer)
    puts "У дилера #{dealer.hand.score} очков"
  end
end
