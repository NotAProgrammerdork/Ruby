#spec/connect_four_spec.rb
require "./lib/connect_four.rb"

describe Connect_Four do
  game = Connect_Four.new
  
  it "returns the grid" do
    expect(game.grid.length).to be > 0
  end
  
  it "returns a winner" do
    expect(game.winner).not_to eq nil
  end
end
