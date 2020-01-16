# frozen_string_literal: true

# Base representation of a player for any game.
class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

# A player participating in a game of Tic-Tac-Toe.
class TicTacToePlayer < Player
  attr_reader :sigil
  def initialize(name, sigil)
    super(name)
    @sigil = sigil
  end
end
