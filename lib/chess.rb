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
    @w_symbols = {
      'w_king' => "♔",
      'w_queen '=> "♕",
      'w_rook' => "♖",
      'w_bishop' => "♗",
      'w_knight' => "♘",
      'w_pawn' => "♙",
    }
    @b_symbols = {
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
    find_row(row.to_i)[find_col(col)]
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

  def rook_moves(turn)
    moves_ary = []
    col_ary = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    row_ary = [1, 2, 3, 4, 5, 6, 7, 8]

    i = col_ary.index(turn[0])
    i = i + 1
    condition = true
    while i < 8 && condition == true #for cases to the rooks right
      if find_piece(col_ary[i], turn[1]) == ' '
        moves_ary << "#{col_ary[i]}#{turn[1]}"
      elsif @b_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{col_ary[i]}#{turn[1]}"
      elsif @b_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false

      elsif @w_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))

        condition = false
      elsif @w_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{col_ary[i]}#{turn[1]}"
      end
      i += 1
    end 

    i = col_ary.index(turn[0])
    i = i - 1
    condition = true
    while i >= 0 && condition == true#for cases to the rooks left
      if find_piece(col_ary[i], turn[1]) == ' '
        moves_ary << "#{col_ary[i]}#{turn[1]}"
      elsif @b_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{col_ary[i]}#{turn[1]}"
      elsif @w_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
      elsif @b_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
      elsif @w_symbols.values.include?(find_piece(col_ary[i], turn[1])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{col_ary[i]}#{turn[1]}"
      end
      i -= 1
    end

    j = row_ary.index(turn[1].to_i) #remember to turn all turn[1].to_i
    j = j + 1
    condition = true
    while j < 8 && condition == true #for all possible cases of the rook moving up
      if find_piece(turn[0], row_ary[j]) == ' '
        moves_ary << "#{turn[0]}#{row_ary[j]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{turn[0]}#{row_ary[j]}"
      elsif @w_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
      elsif @b_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
      elsif @w_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{turn[0]}#{row_ary[j]}"
      end
      j += 1
    end

    j = row_ary.index(turn[1].to_i)
    j = j - 1
    condition = true
    while j >= 0 && condition == true #for all possible movements of the rock going down
      if find_piece(turn[0], row_ary[j]) == ' '
        moves_ary << "#{turn[0]}#{row_ary[j]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{turn[0]}#{row_ary[j]}"
      elsif @w_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @w_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
      elsif @b_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
      elsif @w_symbols.values.include?(find_piece(turn[0], row_ary[j])) && @b_symbols.values.include?(find_piece(turn[0], turn[1]))
        condition = false
        moves_ary << "#{turn[0]}#{row_ary[j]}"
      end
      j -= 1

    end
    moves_ary
  end

  def bishop_moves(turn)
    moves_ary = []
    col_ary = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    row_ary = [1, 2, 3, 4, 5, 6, 7, 8]
    #possible moves towards top left
    condition = true
    c = col_ary.index(turn[0])
    r = row_ary.index(turn[1].to_i)
    c = c - 1
    r = r + 1
    while condition == true && c >= 0 && r < 8
      if find_piece(col_ary[c], row_ary[r]) == ' '
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      end
      c -= 1
      r += 1
    end
    #possible moves towards top right
    condition = true
    c = col_ary.index(turn[0])
    r = row_ary.index(turn[1].to_i)
    c = c + 1
    r = r + 1
    while condition == true && c < 8 && r < 8
      if find_piece(col_ary[c], row_ary[r]) == ' '
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      end
      c += 1
      r += 1
    end
    #possible moves towards bottom left
    condition = true
    c = col_ary.index(turn[0])
    r = row_ary.index(turn[1].to_i)
    c = c - 1
    r = r - 1
    while condition == true && c >= 0 && r >= 0
      if find_piece(col_ary[c], row_ary[r]) == ' '
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      end
      c -= 1
      r -= 1
    end
    #possible moves towards bottom right
    condition = true
    c = col_ary.index(turn[0])
    r = row_ary.index(turn[1].to_i)
    c = c + 1
    r = r - 1
    while condition == true && c < 8 && r >= 0
      if find_piece(col_ary[c], row_ary[r]) == ' '
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      elsif @w_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @w_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
        moves_ary << "#{col_ary[c]}#{row_ary[r]}"
      elsif @b_symbols.values.include?(find_piece(turn[0], turn[1])) && @b_symbols.values.include?(find_piece(col_ary[c], row_ary[r]))
        condition = false
      end
      c += 1
      r -= 1
    end
    moves_ary
  end
    
  def queen_moves(turn)
    rook_moves(turn) + bishop_moves(turn)
  end
  
  def is_white(turn)
    if @w_symbols.values.include?(find_piece(turn[0], turn[1]))
      return true
    else
      return false
    end
  end

  def king_moves(turn)
    moves_ary = []
    col_ary = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    row_ary = [1, 2, 3, 4, 5, 6, 7, 8]

    condition = true
    c = col_ary.index(turn[0])
    r = row_ary.index(turn[1].to_i)
    #possible moves towards top left
    if find_piece(col_ary[c-1], row_ary[r+1]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c-1]}#{row_ary[r+1]}")) || (!is_white(turn) && is_white("#{col_ary[c-1]}#{row_ary[r+1]}"))
        moves_ary << "#{col_ary[c-1]}#{row_ary[r+1]}"
    end
    #moves up
    if find_piece(col_ary[c], row_ary[r+1]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c]}#{row_ary[r+1]}")) || (!is_white(turn) && is_white("#{col_ary[c]}#{row_ary[r+1]}"))
        moves_ary << "#{col_ary[c]}#{row_ary[r+1]}"
    end
    #moves top right
    if find_piece(col_ary[c+1], row_ary[r+1]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c+1]}#{row_ary[r+1]}")) || (!is_white(turn) && is_white("#{col_ary[c+1]}#{row_ary[r+1]}"))
        moves_ary << "#{col_ary[c+1]}#{row_ary[r+1]}"
    end
    #moves right
    if find_piece(col_ary[c+1], row_ary[r]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c+1]}#{row_ary[r]}")) || (!is_white(turn) && is_white("#{col_ary[c+1]}#{row_ary[r]}"))
        moves_ary << "#{col_ary[c+1]}#{row_ary[r]}"
    end
    #moves bottom right
    if find_piece(col_ary[c+1], row_ary[r-1]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c+1]}#{row_ary[r-1]}")) || (!is_white(turn) && is_white("#{col_ary[c+1]}#{row_ary[r-1]}"))
        moves_ary << "#{col_ary[c+1]}#{row_ary[r-1]}"
    end
    #moves down
    if find_piece(col_ary[c], row_ary[r-1]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c]}#{row_ary[r-1]}")) || (!is_white(turn) && is_white("#{col_ary[c]}#{row_ary[r-1]}"))
        moves_ary << "#{col_ary[c]}#{row_ary[r-1]}"
    end
    #moves bottom left
    if find_piece(col_ary[c-1], row_ary[r-1]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c-1]}#{row_ary[r-1]}")) || (!is_white(turn) && is_white("#{col_ary[c-1]}#{row_ary[r-1]}"))
        moves_ary << "#{col_ary[c-1]}#{row_ary[r-1]}"
    end
    #moves left
    if find_piece(col_ary[c-1], row_ary[r]) == ' ' || (is_white(turn) && !is_white("#{col_ary[c-1]}#{row_ary[r]}")) || (!is_white(turn) && is_white("#{col_ary[c-1]}#{row_ary[r]}"))
        moves_ary << "#{col_ary[c-1]}#{row_ary[r]}"
    end
    moves_ary

  end

  def possible_moves(turn)
        case find_piece(turn[0], turn[1])
          #rook_moves
        when '♖' || '♜' then return rook_moves(turn)
          #bishop_moves
        when '♗' 

          #queen_moves
        when '♕'
          #king_moves
        when '♔'
          #knight_moves
        when '♘'
          #pawn_moves
        when '♙'
          #if on row 2 it can move two spaces
          #if a piece is diagonal to it, it can take it
          #if it gets to the end it can become a queen
        end

  end


  def start
    count = 1
    while p1.victory == false && p2.victory == false
      draw_board
      if count.odd?
        print 'white turn, what is your move? '
        turn = gets.chomp.gsub(/\s+/, "")
        
          if possible_moves.include?(turn[-2..-1])



        move(turn[0], turn[1].to_i, turn[-2], turn[-1].to_i)
          end

      else
        print 'black turn, what is your move? '
        turn = gets.chomp.gsub(/\s+/, "")
          if possible_moves.include?(turn[-2..-1])
        move(turn[0], turn[1].to_i, turn[-2], turn[-1].to_i)
          end
      end
      count += 1
    end
  end
end
#a = Game.new
#a.start

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
