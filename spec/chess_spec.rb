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
        @a_game.row2 = '│   │   │   │   │   │ ♘ │   │   │'
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

    describe '#queen_moves' do
      context 'when selected starting coordinate is a queen' do
        it 'will show all possible moves (diagonal and horizontal)' do
        @a_game.row8 = '│   │   │   │   │   │   │   │   │'
        @a_game.row7 = '│   │ ♕ │   │   │   │   │   │   │'
        @a_game.row6 = '│   │   │   │   │   │   │   │   │'
        @a_game.row5 = '│   │   │   │   │   │   │   │   │'
        @a_game.row4 = '│   │   │   │   │ ♖ │   │   │   │'
        expect(@a_game.queen_moves('b7')).to match_array(['a8', 'c8', 'c6', 'a6', 'd5'])
        end
      end
    end

  end

        








end
