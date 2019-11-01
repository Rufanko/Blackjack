# frozen_string_literal: true

require_relative 'bank.rb'
require_relative 'player.rb'
require_relative 'card.rb'
require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'interface'
require_relative 'game'
interface = Interface.new
game = Game.new(interface)
game.run
