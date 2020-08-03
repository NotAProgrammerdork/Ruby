class TicTacToe
    
    def play
        @grid = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        puts <<-'EOF'
  _____ _     _____         _____          
 |_   _(_) __|_   _|_ _  __|_   _|__   ___ 
   | | | |/ __|| |/ _` |/ __|| |/ _ \ / _ \
   | | | | (__ | | (_| | (__ | | (_) |  __/
   |_| |_|\___||_|\__,_|\___||_|\___/ \___|
             "Here's the grid"
                 1 | 2 | 3
                 4 | 5 | 6
                 7 | 8 | 9
        EOF
        puts nil
        @i = 0
        computer_playing
        puts nil
        first_player
    end
    
    private
    def evaluation_1
        if @grid[0] == "X" && @grid[1] == "X" && @grid[2] == "X" || @grid[2] == "X" && @grid[5] == "X" && @grid[8] == "X" || @grid[6] == "X" && @grid[7] == "X" && @grid[8] == "X" || @grid[0] == "X" && @grid[3] == "X" && @grid[6] == "X" || @grid[0] == "X" && @grid[4] == "X" && @grid[8] == "X" || @grid[2] == "X" && @grid[4] == "X" && @grid[6] == "X" || @grid[1] == "X" && @grid[4] == "X" && @grid[7] == "X" || @grid[3] == "X" && @grid[4] == "X" && @grid[5] == "X"
            puts nil
            puts "Player 1 wins"
            again
        else
            if @i == 9
                puts nil
                puts "It's a draw!"
                again
            else
                if @comp == "yes"
                    comp_player
                else
                    user_player
                end
            end
        end
    end
    
    def evaluation_2
        if @grid[0] == "O" && @grid[1] == "O" && @grid[2] == "O" || @grid[2] == "O" && @grid[5] == "O" && @grid[8] == "O" || @grid[6] == "O" && @grid[7] == "O" && @grid[8] == "O" || @grid[0] == "O" && @grid[3] == "O" && @grid[6] == "O" || @grid[0] == "O" && @grid[4] == "O" && @grid[8] == "O" || @grid[2] == "O" && @grid[4] == "O" && @grid[6] == "O" ||  @grid[1] == "O" && @grid[4] == "O" && @grid[7] == "O" || @grid[3] == "O" && @grid[4] == "O" && @grid[5] == "O"
            puts nil
            puts "Player 2 wins"
            again
        else
            first_player
        end
    end
    
    def first_player
        print "First player: "
        first = gets.chomp.to_i
        if @grid[first - 1].ord != 32 || first > 9 || first < 1
            first_player
        else
            @grid[first - 1] = "X"
            puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
            puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
            puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
            puts nil
            @i += 1
            evaluation_1
        end
    end
    
    def comp_player
        second = (rand * 9 + 1).to_i
        if @grid[second - 1].ord != 32 || second > 9 || second < 1
            comp_player
        else
	        print "Second player: "
	        puts second
            @grid[second - 1] = "O"
	        puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
	        puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
            puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
	        puts nil
            @i += 1
            evaluation_2
        end
    end
    
    def user_player
	    print "Second player: "
        second = gets.chomp.to_i
        if @grid[second - 1].ord != 32 || second > 9 || second < 1
            user_player
        else
            @grid[second - 1] = "O"
	        puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
	        puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
            puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
	        puts nil
            @i += 1
            evaluation_2
        end
    end
    
    def again
        loop do
            puts "Do you want to play again? (yes/no)"
            pl_again = gets.chomp
            if pl_again == "yes"
                puts nil
                puts nil
                play
            end
            break if pl_again == "no" || pl_again == "yes"
        end
    end
    
    def computer_playing
        loop do
            puts "Do you want computer to play? (yes/no)"
            @comp = gets.chomp
            break if @comp == "no" || @comp == "yes"
        end
    end
    
end

TicTacToe.new.play
