class TicTacToe
  attr_reader :grid, :game
    
  def initialize
    system "clear"
    @grid = Array.new(9, " ")
    @places = Array(1..9)
    @game = nil
    
    puts "  _____ _     _____         _____"
    puts " |_   _(_) __|_   _|_ _  __|_   _|__   ___"
    puts "   | | | |/ __|| |/ _` |/ __|| |/ _ \\ / _ \\"
    puts "   | | | | (__ | | (_| | (__ | | (_) |  __/"
    puts "   |_| |_|\\___||_|\\__,_|\\___||_|\\___/ \\___|"
    puts
    puts "           The grid:"
    puts "           1 | 2 | 3"
    puts "           4 | 5 | 6"
    puts "           7 | 8 | 9"
    puts
    
    computer_playing
    puts
    print " > First player's name: "
    @player_1 = gets.chomp
    if @comp == "y"
      @player_2 = "Computer"
    else
      print " > Second player's name: "
      @player_2 = gets.chomp
    end
    
    system "clear"
    print_grid
    first_player
  end
    
  private
    
  def print_grid
    puts
    0.step(6,3) do |i|
      print "  #{@grid[i]} | #{@grid[i+1]} | #{@grid[i+2]}\n"
    end
    puts
  end
  
  def evaluation(mark, pos)
    @grid[pos-1] = mark
    @places.delete(pos)

    # horizontal checking
    0.step(6,3) do |i|
      if @grid[i] == mark &&
         @grid[i+1] == mark &&
         @grid[i+2] == mark

        return winning(mark)
      end		
    end

    # vertical checking
    0.upto(2) do |i|
      if @grid[i] == mark &&
         @grid[i+3] == mark &&
         @grid[i+6] == mark

        return winning(mark)
      end
    end

    # diagonal checking
    if @grid[0] == mark && @grid[4] == mark && @grid[8] == mark ||
       @grid[2] == mark && @grid[4] == mark && @grid[6] == mark

      return winning(mark)
    end

    # slot checking
    return winning("none") if @places.empty?

    # continue
    system "clear"
    print_grid
    mark == "O" ? second_player : first_player
  end
    
  def winning(mark)
    print_grid
    if mark == "O"
      @game = "#{@player_1} wins!"
    elsif mark == "X"
      @game = "#{@player_2} wins!"
    else
      @game = "It's a draw!"
    end
    puts
    puts @game
    again
  end
    
  def first_player
    print "First player: "
    pos = gets.chomp.to_i.abs
    pos != 0 && @grid[pos-1] == " " ? evaluation("O", pos) : first_player
  end
    
  def second_player
    if @comp == "y"
      pos = @places.sample
    else
	   print "Second player: "
       pos = gets.chomp.to_i
    end
    pos != 0 && @grid[pos-1] == " " ? evaluation("X", pos) : second_player
  end
    
  def again
    puts "Do you want to play again?(y/n)"
    pl_again = gets.chomp.downcase
    return initialize if pl_again == "y"
    return again unless pl_again == "n"
  end
    
  def computer_playing
    puts "Do you want computer to play?(y/n)"
    @comp = gets.chomp.downcase
    computer_playing unless @comp == "y" || @comp == "n"
  end
end