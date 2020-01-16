# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# Mediates a game of Tic-Tac-Toe.
class TicTacToeManager
  POSITION_HASH = {
    UL: [0, 0],
    UM: [0, 1],
    UR: [0, 2],
    ML: [1, 0],
    MM: [1, 1],
    MR: [1, 2],
    BL: [2, 0],
    BM: [2, 1],
    BR: [2, 2]
  }.freeze

  def play_game
    @player_one, @player_two = create_players
    @curr_player = choose_first_player
    @board = TicTacToeBoard.new
    @remaining_turns = 9
    next_turn until game_over?
  end

  private

  def create_players
    puts "Player One, you will play as 'X'. What is your name?"
    player_one = TicTacToePlayer.new(gets.chomp, 'X')
    puts "Player Two, you will play as 'O'. What is your name?"
    player_two = TicTacToePlayer.new(gets.chomp, 'O')
    [player_one, player_two]
  end

  def choose_first_player
    first_player = rand(2).zero? ? @player_one : @player_two
    puts "Congrats, #{first_player.name}, you're going first!"
    first_player
  end

  def switch_current_player
    @curr_player = @curr_player == @player_one ? @player_two : @player_one
  end

  def game_over?
    if @remaining_turns > 5
      switch_current_player
      false
    elsif @board.three_consecutive? @curr_player.sigil
      puts @board
      puts "Congrats, #{@curr_player.name}, you win!"
      true
    elsif @remaining_turns.zero?
      puts @board
      puts 'Looks like a tie!'
      true
    else
      switch_current_player
      false
   end
  end

  def next_turn
    puts @board
    puts "#{@curr_player.name}, please make your move."
    row, col = get_valid_position
    @board.add_piece(@curr_player.sigil, row, col)
    @remaining_turns -= 1
  end

  def get_valid_position
    position = gets.chomp.upcase.to_sym
    until valid_position? position
      puts @board
      puts "#{@curr_player.name}, that isn't a valid position. Please try again."
      position = gets.chomp.upcase.to_sym
    end
    POSITION_HASH[position]
  end

  def valid_position?(position)
    if POSITION_HASH.keys.include? position
      row, col = POSITION_HASH[position]
      @board.space_available?(row, col)
    else
      false
    end
  end
end

TicTacToeManager.new.play_game
