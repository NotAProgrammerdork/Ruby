class Connect_Four
  attr_reader :grid
  attr_reader :winner
  
  def initialize
  	system "clear"
  	# columns
    @col1 = Array.new(6, " ")
    @col2 = Array.new(6, " ")
    @col3 = Array.new(6, " ")
    @col4 = Array.new(6, " ")
    @col5 = Array.new(6, " ")
    @col6 = Array.new(6, " ")
    @col7 = Array.new(6, " ")
    
    # make grid, default guesses and winner
    @grid = [@col1, @col2, @col3, @col4, @col5, @col6, @col7]
    @guesses = [1,2,3,4,5,6,7]
    @winner = nil
    
    puts "   ____                            _     _____"
    puts "  / ___|___  _ __  _ __   ___  ___| |_  |  ___|__  _   _ _ __"
    puts " | |   / _ \\| '_ \\| '_ \\ / _ \\/ __| __| | |_ / _ \\| | | | '__|"
    puts " | |__| (_) | | | | | | |  __/ (__| |_  |  _| (_) | |_| | |"
    puts "  \\____\\___/|_| |_|_| |_|\\___|\\___|\\__| |_|  \\___/ \\__,_|_|"
    puts
    
    comp_choice
    print "> First player's name: "
    @name_1 = gets.chomp
    if @computer == "y"
      @name_2 = "Computer"
    else
      print "> Second player's name: "
      @name_2 = gets.chomp
    end
    
    system "clear"
    print_slots
    first_player
  end
  
  private
  
  def comp_choice
    puts "Do you want computer to play? (y/n)"
    @computer = gets.chomp.downcase
    puts
    comp_choice unless @computer == "y" || @computer == "n"
  end
  
  def print_grid(grid=@grid)
    puts
    0.upto(5) do |row|
      print "   "
      0.upto(6) do |col|
        print "|#{grid[col][row]}"
        print "|\n" if col == 6
      end
    end
    puts
  end
  
  def put_sth_in_slot(column, sth)
    0.upto(5) do |row|
      next unless column[row+1].nil? || column[row+1] != " "
      column[row] = sth if column[row] == " "
      break
    end
  end
  
  def print_slots
  	# clone columns
    grid = [@col1.clone, @col2.clone, @col3.clone, @col4.clone, @col5.clone, @col6.clone, @col7.clone]
    grid.each_with_index do |column, idx|
      put_sth_in_slot(column, idx+1)
    end
    print_grid(grid)
  end
  
  def marking_slot(mark, slot)
  	column = @grid[slot-1]
    put_sth_in_slot(column, mark)
    @guesses.delete(slot) unless column.include? " "
  end
  
  def winning(from)
    print_grid
    puts
    puts
    @winner = from
    puts "#{from} wins!"
    again
  end
  
  def checking(mark, from)
    0.upto(3) do |col|
      # horizontal checking
      0.upto(5) do |row|
        if @grid[col][row] == mark &&
           @grid[col+1][row] == mark &&
           @grid[col+2][row] == mark &&
           @grid[col+3][row] == mark
        
          return winning(from)
        end
      end
      
      # diagonal checking
      0.upto(2) do |row|
        if @grid[col][row] == mark &&
           @grid[col+1][row+1] == mark &&
           @grid[col+2][row+2] == mark &&
           @grid[col+3][row+3] == mark ||
           @grid[col][row+3] == mark &&
           @grid[col+1][row+2] == mark &&
           @grid[col+2][row+1] == mark &&
           @grid[col+3][row] == mark
         
          return winning(from)
        end
      end
    end
    
    # vertical checking
    @grid.each do |col|
      0.upto(2) do |row|
        if col[row] == mark &&
           col[row+1] == mark &&
           col[row+2] == mark &&
           col[row+3] == mark
    			 
          return winning(from)
        end
      end
    end
    
    # continue
    system "clear"
    print_slots
    from == @name_1 ? second_player : first_player
  end
  
  def again
    puts
    puts "Do you want to play again?(y/n)"
    play_again = gets.chomp.downcase
    return initialize if play_again == "y"
    return again unless play_again == "n"
  end
  
  def accept_input(slot)
  	slot.between?(1, 7) && @guesses.include?(slot)
  end
  
  def next_player(from, slot)
  	mark = (from == @name_1) ? "O" : "X"
  	marking_slot(mark, slot)
    return checking(mark, from) unless @guesses.empty?
  	@winner = "Nobody"
    puts "It's a draw!"
  end
  
  def first_player
    print "   #{@name_1} > "
    slot = gets.chomp.to_i
    puts
    accept_input(slot) ? next_player(@name_1, slot) : first_player
  end
  
  def second_player
  	if @computer == "y"
      slot = @guesses.sample
    else
      print "   #{@name_2} > "
      slot = gets.chomp.to_i
      puts
  	end
    accept_input(slot) ? next_player(@name_2, slot) : second_player
  end
end