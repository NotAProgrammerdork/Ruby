#spec/tictactoe_spec.rb
require "./lib/tictactoe.rb"

describe TicTacToe do
  game = TicTacToe.new
  
  it "returns the grid" do
    expect(game.grid.length).to be > 0
  end
  
  it "returns a winner" do
    expect(game.game).not_to eq nil
  end
end
