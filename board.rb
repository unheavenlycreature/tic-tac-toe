# frozen_string_literal: true

# A Tic-Tac-Toe board.
class TicTacToeBoard
  def initialize
    @board = [[nil, nil, nil],
              [nil, nil, nil],
              [nil, nil, nil]]
  end

  def add_piece(sigil, row, col)
    if space_available?(row, col)
      @board[row][col] = sigil
      true
    else
      false
    end
  end

  def space_available?(row, col)
    @board[row][col].nil?
  end

  def three_consecutive?(sigil)
    three_in_a_row?(@board, sigil) || three_in_a_row?(@board.transpose, sigil) || three_in_a_diagonal?(sigil)
  end

  def to_s
    board_string = '_' * 13
    @board.each do |row|
      board_string += "\n|" + row_string(row) + "\n"
      board_string += '_' * 13
    end
    board_string
  end

  private

  def three_in_a_row?(board, sigil)
    board[0].all?(sigil) || board[1].all?(sigil) || board[2].all?(sigil)
  end

  def three_in_a_diagonal?(sigil)
    return false if @board[1][1] != sigil

    [@board[0][0], @board[2][2]].all?(sigil) || [@board[0][2], @board[2][0]].all?(sigil)
  end

  def row_string(row)
    row_string = ''
    row.each do |sigil|
      space = sigil.nil? ? '   |' : " #{sigil} |"
      row_string += space
    end
    row_string
  end
end
