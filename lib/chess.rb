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

class Player
  attr_accessor :color, :victory
  def initialize(color, victory = false)
    @victory = victory
    @color = color
  end
end


class Game < ChessSymbols
  attr_accessor :row8, :row7, :row6, :row5, :row4, :row3, :row2, :row1, :p1, :p2
  def initialize
    @row8 = "│ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │"
    @row7 = "│ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │"
    @row6 = "│   │   │   │   │   │   │   │   │"
    @row5 = "│   │   │   │   │   │   │   │   │"
    @row4 = "│   │   │   │   │   │   │   │   │"
    @row3 = "│   │   │   │   │   │   │   │   │"
    @row2 = "│ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │"
    @row1 = "│ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │"
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
@p1 = Player.new('white')
@p2 = Player.new('black')
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

  def find_piece(col, row)
    find_row(row)[find_col(col)]
  end

  def place(piece, col, row)
    find_row(row)[find_col(col)] = piece
  end

  def remove(col, row)
    find_row(row)[find_col(col)] = ' '
  end

  def move(col, row, to_col, to_row)
    place(find_piece(col, row), to_col, to_row)
    remove(col, row)
  end

  def start
    count = 1
    while p1.victory == false && p2.victory == false
      draw_board
      if count.odd?
        print 'white turn, what is your move? '
        turn = gets.chomp
        move(turn[0], turn[1].to_i, turn[3], turn[4].to_i)
      else
        print 'black turn, what is your move? '
        turn = gets.chomp
        move(turn[0], turn[1].to_i, turn[3], turn[4].to_i)
      end
      count += 1
    end
  end
end
a = Game.new
a.start

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
