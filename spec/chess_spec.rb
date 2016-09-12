require 'chess'

describe 'Game' do

  before(:each) do
    @a_game = Game.new
  end

  describe '#draw_board' do
    context 'when #draw_board is called' do
      it 'will print out an 8x8 board' do
        expect{@a_game.draw_board}.to output(
          "┌───┬───┬───┬───┬───┬───┬───┬───┐
│ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │
├───┼───┼───┼───┼───┼───┼───┼───┤
│ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │
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
│ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │
└───┴───┴───┴───┴───┴───┴───┴───┘"
        ).to_stdout
      end
    end
  end

  describe '#find_row' do
    context 'when given a number' do
      it 'returns the corresponding row_number' do
        @a_game.row3 = '│   │   │   │   │   │ ♘ │   │   │'
        expect(@a_game.find_row(3)).to eql('│   │   │   │   │   │ ♘ │   │   │')
      end
    end
  end

  describe '#find_col' do
    context 'when given a letter' do
      it 'returns the corresponding column number in string' do

        expect(@a_game.find_col('c')).to eql(10)
      end
    end
  end


  describe '#place' do
    context 'when a piece, column and row is given to #place' do
      it 'finds that place on the grid and replaces it with piece' do
        @a_game.place('♘', 'f', 4)
        expect(@a_game.row4).to eql('│   │   │   │   │   │ ♘ │   │   │')
      end
    end
  end

  describe '#remove' do
    context 'when a piece at a particular column and row is designated to move' do
      it 'erases that piece from that column and row' do
        @a_game.row5 = '│   │   │ ♗ │   │   │ ♘ │   │   │'
        @a_game.remove('f', 5)
        expect(@a_game.row5).to eql('│   │   │ ♗ │   │   │   │   │   │')
      end
    end
  end

  describe '#find_piece' do
    context 'when given a set of coordinates' do
      it 'returns the string that corresponds' do
        @a_game.row3 = '│   │   │ ♗ │   │   │ ♘ │   │   │'
        expect(@a_game.find_piece('c', 3)).to eql('♗')
      end
    end
  end



  describe '#move' do
    context 'when two sets of coordinates are given' do
      it 'erases the piece from the first set of coordinates' do
        @a_game.row3 = '│   │   │ ♗ │   │   │ ♘ │   │   │'
        @a_game.move('c', 3, 'd', 4)
        expect(@a_game.row3).to eql('│   │   │   │   │   │ ♘ │   │   │')
      end

      it 'writes the piece to the second set of coordinates' do
        @a_game.row3 = '│   │   │ ♗ │   │   │ ♘ │   │   │'
        @a_game.move('c', 3, 'd', 4)
        expect(@a_game.row4).to eql('│   │   │   │ ♗ │   │   │   │   │')
      end
    end
  end

  describe '#rook_moves' do
    context 'when disignated movement starts with a rook' do
      it 'will create an array with all possible legal moves to the right' do
        @a_game.row4 = '│   │   │   │   │   │ ♘ │   │   │'
        @a_game.row3 = '│   │   │   │   │ ♘ │ ♖ │   │   │'
        @a_game.row2 = '│   │   │   │   │   │ ♔ │   │   │'
        expect(@a_game.rook_moves('f3')).to eql(['g3', 'h3'])
      end

      it 'will create and array of possible moves in all directions that are non diagonal' do
        @a_game.row5 = '│   │   │   │   │   │ ♘ │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │ ♘ │   │ ♖ │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │ ♘ │   │   │'
        expect(@a_game.rook_moves('f3')).to match_array(['g3', 'h3', 'e3', 'f2', 'f4'])
      end

      it 'will include coordinates where there are black pieces to be captured' do 
        @a_game.row5 = '│   │   │   │   │   │ ♘ │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │ ♘ │   │ ♖ │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │ ♟ │   │   │'
        expect(@a_game.rook_moves('f3')).to match_array(['g3', 'h3', 'e3', 'f2', 'f4', 'f1'])
      end

      it 'includes coordinates of all black pieces in all directions' do
        @a_game.row5 = '│   │   │   │   │   │ ♟ │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │ ♟ │   │ ♖ │   │ ♟ │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │ ♟ │   │   │'
        expect(@a_game.rook_moves('f3')).to match_array(['g3', 'h3', 'd3', 'e3', 'f2', 'f4', 'f1', 'f5'])
      end

      it 'works for black pieces as well' do 
        @a_game.row5 = '│   │   │   │   │   │ ♞ │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │ ♞ │   │ ♜ │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │ ♙ │   │   │'
        expect(@a_game.rook_moves('f3')).to match_array(['g3', 'h3', 'e3', 'f2', 'f4', 'f1'])
      end
    end
  end

  describe '#bishop_moves' do 
    context 'when bishop is the designated piece to be moved' do
      it 'will show all possible moves to the top left' do
        @a_game.row8 = '│   │   │ ♘ │   │   │   │   │   │'
        @a_game.row7 = '│   │ ♗ │   │   │   │   │   │   │'
        @a_game.row6 = '│ ♘ │   │ ♘ │   │   │   │   │   │'
        expect(@a_game.bishop_moves('b7')).to match_array(['a8'])
      end

      it 'will show all possible moves in any diagonal direction' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │ ♗ │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │ ♘ │   │   │   │   │'
        expect(@a_game.bishop_moves('b7')).to match_array(['a8', 'c8', 'c6', 'a6'])
      end

      it 'will also include the possibility of taking an opposite colour piece' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │ ♗ │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │ ♞ │   │   │   │   │'
        expect(@a_game.bishop_moves('b7')).to match_array(['a8', 'c8', 'c6', 'a6', 'd5'])
      end

      it 'also works for black pieces' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │ ♝ │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │ ♖ │   │   │   │   │'
        expect(@a_game.bishop_moves('b7')).to match_array(['a8', 'c8', 'c6', 'a6', 'd5'])
      end
    end
  end

  describe '#queen_moves' do
    context 'when selected starting coordinate is a queen' do
      it 'will show all possible moves (diagonal and horizontal)' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │ ♕ │   │   │ ♖ │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │ ♖ │   │   │ ♖ │   │   │   │'
        expect(@a_game.queen_moves('b7')).to match_array(['a8', 'c8', 'c6', 'a6', 'd5', 'a7', 'c7', 'd7', 'b8', 'b6', 'b5'])
      end

      it 'will show all possible moves (diagonal and horizontal)' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │ ♕ │   │   │ ♜ │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │ ♜ │   │   │ ♜ │   │   │   │'
        expect(@a_game.queen_moves('b7')).to match_array(['a8', 'c8', 'c6', 'a6', 'd5', 'a7', 'c7', 'd7', 'b8', 'b6', 'b5', 'b4', 'e4', 'e7'])
      end
    end
  end

  describe '#king_moves' do
    context 'when selected piece is the king' do
      it 'will show all possible moves 1 square in all directions' do
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │ ♔ │   │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.king_moves('c5')).to match_array(['d6', 'd5', 'd4', 'c6', 'c4', 'b4', 'b5', 'b6'])
      end

      it 'cannot move where another piece is' do
        @a_game.row6 = '│   │ ♖ │ ♖ │ ♖ │   │   │   │   │'
        @a_game.row5 = '│   │   │ ♔ │ ♖ │   │   │   │   │'
        @a_game.row4 = '│   │ ♖ │ ♖ │   │   │   │   │   │'
        expect(@a_game.king_moves('c5')).to match_array(['b5', 'd4'])
      end

      it 'can, however, move to occupied coordinates if it is of opposite color' do
        @a_game.row6 = '│   │ ♖ │ ♜ │ ♖ │   │   │   │   │'
        @a_game.row5 = '│   │   │ ♔ │ ♖ │   │   │   │   │'
        @a_game.row4 = '│   │ ♜ │ ♖ │   │   │   │   │   │'
        expect(@a_game.king_moves('c5')).to match_array(['b5', 'd4', 'c6', 'b4'])
      end

      it 'works for the black color' do
        @a_game.row6 = '│   │ ♜ │ ♖ │ ♜ │   │   │   │   │'
        @a_game.row5 = '│   │   │ ♚ │ ♜ │   │   │   │   │'
        @a_game.row4 = '│   │ ♖ │ ♜ │   │   │   │   │   │'
        expect(@a_game.king_moves('c5')).to match_array(['b5', 'd4', 'c6', 'b4'])
      end

      it 'should return an empty array if it is cornered in at an edge' do
        @a_game.row8 = '│ ♚ │ ♜ │   │   │   │   │   │   │'
        @a_game.row7 = '│ ♜ │ ♜ │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.king_moves('a8')).to match_array([])
      end
    end
  end

  describe '#is_white' do
    context 'when given a coordinate' do 
      it 'returns true if that coordinate contains a white piece' do
        @a_game.row5 = '│   │   │ ♔ │ ♖ │   │   │   │   │'
        expect(@a_game.is_white('c5')).to eql(true)
      end
    end
  end

  describe '#knight_moves' do
    context 'when knight is designated to move' do
      it 'returns array of all possible coordinates it can move to' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │   │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │ ♘ │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.knight_moves('d5')).to match_array(['c7', 'e7', 'f6', 'f4', 'e3', 'c3', 'b4', 'b6'])  
      end

      it 'does not go off the board' do
        @a_game.row8 = '│ ♘ │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │   │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.knight_moves('a8')).to match_array(['c7', 'b6'])  
      end

      it 'works for black knights as well' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │   │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│ ♞ │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.knight_moves('a5')).to match_array(['b7', 'b3', 'c6', 'c4'])  
      end

    end
  end

  describe '#pawn_moves' do
    context 'when disginated piece is a white pawn' do 
      it 'gives array of its movement choice' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │   │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│ ♙ │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.pawn_moves('a4')).to match_array(['a5'])  
      end

      it 'can move forward two squares if it is on row 2 for white' do
        expect(@a_game.pawn_moves('e2')).to match_array(['e3', 'e4'])
      end

      it 'can move diagonally 1 square to the right if those squares have opposite colored pieces on them' do
        @a_game.row3 = '│   │   │   │   │   │ ♟ │   │   │'
        expect(@a_game.pawn_moves('e2')).to match_array(['e3', 'e4', 'f3'])
      end
      
      it 'can move diagonally 1 square to the left if that square has a different colored piece on it' do
        @a_game.row3 = '│   │   │   │   │   │ ♟ │   │   │'
        expect(@a_game.pawn_moves('g2')).to match_array(['g3', 'g4', 'f3'])
      end
    end

    context 'when disginated piece is a black pawn' do 
      it 'gives array of its movement choice' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │   │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │ ♟ │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.pawn_moves('d6')).to match_array(['d5'])  
      end

      it 'can move forward two squares if it is on row 7 for black' do
        expect(@a_game.pawn_moves('e7')).to match_array(['e6', 'e5'])
      end

      it 'can move diagonally 1 square to the right if that square has an opposite colored piece on it' do
        @a_game.row6 = '│   │   │   │   │   │ ♙ │   │   │'
        expect(@a_game.pawn_moves('e7')).to match_array(['e6', 'e5', 'f6'])
      end

      it 'can move diagonally 1 square to the left if that square has a different colored piece on it' do
        @a_game.row6 = '│   │   │   │   │   │ ♙ │   │   │'
        expect(@a_game.pawn_moves('g7')).to match_array(['g6', 'g5', 'f6'])
      end
    end

    context 'when the caveat en passant is a possibility' do
      it 'allows a white pawn to take a black pawn to its left right after the black pawn moves two spaces forward' do
        @a_game.past_moves = ['e7e5']
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │   │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │ ♟ │ ♙ │   │ ♙ │'
        expect(@a_game.pawn_moves('f5')).to match_array(['f6', 'e6'])
      end

      it 'allows a white pawn to take a black pawn to its right after the black pawn moves two spaces forward' do
        @a_game.past_moves = ['e7e5']
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │   │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │ ♙ │ ♟ │   │   │ ♙ │'
        expect(@a_game.pawn_moves('d5')).to match_array(['d6', 'e6'])
      end

      it 'allows a black pawn to take a white pawn on its left after the white pawn moves two spaces forward from row2' do
        @a_game.past_moves = ['f2f4']
        @a_game.row4 = '│   │   │   │   │   │ ♙ │ ♟ │ ♙ │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.pawn_moves('g4')).to match_array(['g3', 'f3'])
      end

      it 'allows a black pawn to take a white pawn on its right, after the white pawn moves two spaces forward from row2' do
        @a_game.past_moves = ['f2f4']
        @a_game.row4 = '│   │   │   │   │ ♟ │ ♙ │   │ ♙ │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │'
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│   │   │   │   │   │   │   │   │'
        expect(@a_game.pawn_moves('e4')).to match_array(['e3', 'f3'])
      end
    end
  end

  describe '#all_white_moves' do
    context 'given the color white' do
    it 'returns array with all possible moves of all white pieces' do
        @a_game.row8 = "│ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │"  
        @a_game.row7 = "│ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │" 
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │' 
        @a_game.row2 = '│   │   │   │   │   │   │   │   │'
        @a_game.row1 = '│ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │'
        expect(@a_game.all_moves('white')).to match_array(['a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', 'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4'])
    end
    end

    context 'given the color black' do
    it 'returns array with all possible moves of all white pieces' do
        @a_game.row8 = "│ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │"  
        @a_game.row7 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row6 = '│ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │   │   │   │   │'
        @a_game.row3 = '│   │   │   │   │   │   │   │   │' 
        @a_game.row2 = '│ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │'
        @a_game.row1 = '│ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │'
        expect(@a_game.all_moves('black')).to match_array(['a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5'])
    end
    end
  end
  
  describe '#check?' do
    context 'when an piece on the opposing side can take the king' do
      it 'will let the user know it is in check' do
        @a_game.row8 = "│   │   │   │   │ ♚ │   │   │   │" 
        @a_game.row7 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row6 = "│   │   │   │   │   │ ♟ │   │   │" 
        @a_game.row5 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row4 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row3 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row2 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row1 = "│   │   │   │ ♔ │ ♖ │   │   │   │" 
        expect(@a_game.check?('black')).to eql(true)
      end
    end
  end
  
  describe '#next_moves' do
    it 'builds a tree of all the possible moves for white at that point of the game' do
        @a_game.row8 = "│   │   │   │   │   │ ♚ │   │   │" 
        @a_game.row7 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row6 = "│   │   │   │   │   │ ♟ │   │   │" 
        @a_game.row5 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row4 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row3 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row2 = "│   │   │   │   │   │   │   │   │" 
        @a_game.row1 = "│   │   │   │ ♔ │ ♖ │   │   │   │" 
        expect(@a_game.next_moves('white').child.length).to eql(14)
    end
  end




      

end

