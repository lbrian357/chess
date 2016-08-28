class ChessSymbols
  attr_accessor :w_king, :w_queen, :w_rook, :w_bishop, :w_pawn, :b_king, :b_queen, :b_rook, :b_bishop, :b_knight, :b_pawn
  def initialize
  @w_king = "♔"
  @w_queen = "♕"
  @w_rook = "♖"
  @w_bishop = "♗"
  @w_knight = "♘"
  @w_pawn = "♙"
  @b_king = "♚"
  @b_queen = "♛"
  @b_rook = "♜"
  @b_bishop = "♝"
  @b_knight = "♞"
  @b_pawn = "♟"
  end

end

class Game < ChessSymbols
  attr_accessor :row8, :row7, :row6, :row5, :row4, :row3, :row2, :row1
  def initialize
    @row8 = "│   │   │   │   │   │   │   │   │"
    @row7 = "│   │   │   │   │   │   │   │   │"
    @row6 = "│   │   │   │   │   │   │   │   │"
    @row5 = "│   │   │   │   │   │   │   │   │"
    @row4 = "│   │   │   │   │   │   │   │   │"
    @row3 = "│   │   │   │   │   │   │   │   │"
    @row2 = "│   │   │   │   │   │   │   │   │"
    @row1 = "│   │   │   │   │   │   │   │   │"
    @mid_row = "├───┼───┼───┼───┼───┼───┼───┼───┤"
    @top_row = "┌───┬───┬───┬───┬───┬───┬───┬───┐"
    @bottom_row = "└───┴───┴───┴───┴───┴───┴───┴───┘"
@symbols = {
  'w_king' => "♔",
  'w_queen '=> "♕",
  'w_rook' => "♖",
  'w_bishop' => "♗",
  'w_knight' => "♘",
  'w_pawn' => "♙",
  'b_king' => "♚",
  'b_queen' => "♛",
  'b_rook' => "♜",
  'b_bishop' => "♝",
  'b_knight' => "♞",
  'b_pawn' => "♟"
}
  end

  def draw_board
    print "#{@top_row}\n#{@row8}\n#{@mid_row}\n#{@row7}\n#{@mid_row}\n#{@row6}\n#{@mid_row}\n#{@row5}\n#{@mid_row}\n#{@row4}\n#{@mid_row}\n#{@row3}\n#{@mid_row}\n#{@row2}\n#{@mid_row}\n#{@row1}\n#{@bottom_row}"
  end

  def find_col(col)
    if col == 'a'
      return 2
      elsif col == 'b'
      return 6
      elsif col == 'c'
      return 10
      elsif col == 'd'
      return 14
      elsif col == 'e'
      return 18
      elsif col == 'f'
      return 22
      elsif col == 'g'
      return 26
      elsif col == 'h'
      return 30
    end
  end
  
  def find_row(number)
    if number == 1
      return row1
    elsif number == 2
      return row2
      elsif number == 3
      return row3 
      elsif number == 4
      return row4
      elsif number == 5
      return row5
      elsif number == 6
      return row6
      elsif number == 7
      return row7
      elsif number == 8
      return row8
    end
  end


  def place(piece, col, row)
    find_row(row)[find_col(col)] = @symbols[piece]
  end

end

=begin
│ ─ ┌ ┐ └ ┘ ┬ ┴ ├ ┤ ┼

┌───┬───┬───┬───┬───┬───┬───┬───┐
│   │   │   │   │   │   │   │   │
├───┼───┼───┼───┼───┼───┼───┼───┤
│   │   │   │   │   │   │   │   │
├───┼───┼───┼───┼───┼───┼───┼───┤
│   │   │   │   │   │   │   │   │
├───┼───┼───┼───┼───┼───┼───┼───┤
│   │   │   │   │   │   │   │   │
├───┼───┼───┼───┼───┼───┼───┼───┤
│   │   │   │   │   │   │   │   │
├───┼───┼───┼───┼───┼───┼───┼───┤
│   │   │   │   │   │   │   │   │
├───┼───┼───┼───┼───┼───┼───┼───┤
│ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │
├───┼───┼───┼───┼───┼───┼───┼───┤
│   │   │   │   │   │   │   │   │
└───┴───┴───┴───┴───┴───┴───┴───┘
=end
