require "yaml"

class Hangman
    def play
        puts <<-'EOF'
  _   _                                         
 | | | | __ _ _ __   __ _ _ __ ___   __ _ _ __  
 | |_| |/ _` | '_ \ / _` | '_ ` _ \ / _` | '_ \ 
 |  _  | (_| | | | | (_| | | | | | | (_| | | | |
 |_| |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|
                    |___/                       
          Type "save" to save the game
Type one letter at a time or type the entire word
        EOF
        puts
        choice = ""
        loop do
            puts "Do you want to load a game? (yes/no)"
            print "> "
            choice = gets.chomp
            break if choice == "yes" || choice == "no"
        end
        loop do
            if choice == "yes"
                begin
                    load
                    @sample = @loaded[0]
                    @array = @loaded[1]
                    break
                rescue
                    puts "There's no save file!"
                    choice = "no"
                end
            elsif choice == "no"
                selectWords
                @array = Array.new @sample.length, "_"
                break
            end
        end
        puts
        @error_counter = 0
        getting_input
    end
    
    private
    
    def dictionary
        @sample = File.read("5desk.txt").split.sample
    end
    
    def selectWords
        dictionary
        unless @sample.length >= 5 && @sample.length <= 12
            selectWords
        end
    end
    
    def getting_input
        puts "There's a word of #{@array.length} letters..."
        puts @array.join " "
        puts
        loop do
            print "> "
            @letter = gets.chomp
            integer = Integer(@letter) rescue false
            if @letter.downcase == @sample.downcase
                winning
                break
            end
            if @letter.downcase == "save"
                save
                puts "Game saved! Closing..."
                break
            end
            unless @letter.length == 1 && integer == false
                puts "Please enter a valid letter!"
                puts
                next
            end
            unless @sample.include?(@letter)
                @error_counter += 1
            end
            evaluating
            if @array.join("") == @sample
                winning
                break
            end
            if @error_counter == 6
                losing
                break
            end
        end
    end

    def evaluating
        @sample.split("").each_with_index do |i, index|
            @array[index] = i if i.downcase == @letter.downcase
        end
        the_hangman
        puts @array.join " "
        puts
    end

    def winning
        puts
        puts "Rescued!"
        puts "The word was: \"#{@sample}\""
        puts "You win!"
        again
    end

    def losing
        puts
        puts "Hanged!"
        puts "The word was: \"#{@sample}\""
        puts "You lose..."
        again
    end

    def again
        loop do
            puts "Do you want to play again? (yes/no)"
            print "> "
            choice = gets.chomp
            puts
            if choice == "yes"
                play
            end
            break if choice == "yes" || choice == "no"
        end
    end
    
    def save
        File.open("hangman.sav", "w") { |file| YAML.dump([@sample, @array], file) }
    end
    
    def load
        File.open("hangman.sav", "r") { |file| @loaded = YAML.load(file) }
    end

    def the_hangman
        if @error_counter == 0
            print "  ____     \n";
            print " |    |    \n";
            print " |         \n";
            print " |         \n";
            print " |         \n";
            print "---        \n";
            puts
        elsif @error_counter == 1
            print "  ____     \n";
            print " |    |    \n";
            print " |    O    \n";
            print " |         \n";
            print " |         \n";
            print "---        \n";
            puts
        elsif @error_counter == 2
            print "  ____     \n";
            print " |    |    \n";
            print " |    O    \n";
            print " |    |    \n";
            print " |         \n";
            print "---        \n";
            puts
        elsif @error_counter == 3
            print "  ____     \n";
            print " |    |    \n";
            print " |    O    \n";
            print " |   /|    \n";
            print " |         \n";
            print "---        \n";
            puts
        elsif @error_counter == 4
            print "  ____     \n";
            print " |    |    \n";
            print " |    O    \n";
            print " |   /|\\  \n";
            print " |         \n";
            print "---        \n";
            puts
        elsif @error_counter == 5
            print "  ____     \n";
            print " |    |    \n";
            print " |    O    \n";
            print " |   /|\\  \n";
            print " |   /     \n";
            print "---        \n";
            puts
        elsif @error_counter == 6
            print "  ____     \n";
            print " |    |    \n";
            print " |    O    \n";
            print " |   /|\\  \n";
            print " |   / \\  \n";
            print "---        \n";
            puts
        end
    end
end

Hangman.new.play