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
│   │   │   │   │   │   │   │   │
├───┼───┼───┼───┼───┼───┼───┼───┤
│   │   │   │   │   │   │   │   │
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
@a_game.place('w_knight', 'f', 4)
        expect(@a_game.row4).to eql('│   │   │   │   │   │ ♘ │   │   │')
      end
    end
  end

end
