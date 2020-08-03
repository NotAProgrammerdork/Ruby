class Mastermind
    @@full_colors = ["red", "green", "blue", "pink", "white", "black", "cyan"]
        
    def play
        puts <<-'EOF'
  __  __           _                      _           _ 
 |  \/  | __ _ ___| |_ ___ _ __ _ __ ___ (_)_ __   __| |
 | |\/| |/ _` / __| __/ _ \ '__| '_ ` _ \| | '_ \ / _` |
 | |  | | (_| \__ \ ||  __/ |  | | | | | | | | | | (_| |
 |_|  |_|\__,_|___/\__\___|_|  |_| |_| |_|_|_| |_|\__,_|
        "Please don't use commas (use spaces)!"
        EOF
        puts nil
        puts "Do you want to shuffle? (yes/no)"
        playing = ""
        loop do
            shuffler = gets.chomp
            puts nil
            if shuffler == "yes"
                user_shuffling
                puts "Do you want computer to play? (yes/no)"
                loop do
                    playing = gets.chomp
                    puts nil
                    break if playing == "yes" || playing == "no"
                end
            elsif shuffler == "no"
                computer_shuffling
            end
            break if shuffler == "yes" || shuffler == "no"
        end
        if playing == "yes"
            computer_match
        else
            user_match
        end
    end
    
    private
    def user_shuffling
        p @@full_colors
        puts "Choice between these values (please don't use commas!)"
        @colors = gets.chomp.split(" ")
        puts nil
    end
    
    def computer_shuffling
        i = 0
        @colors = []
        loop do
            sample = @@full_colors.sample
            unless @colors.include?(sample)
                @colors << sample
                i += 1
            end
            break if i == 4
        end
    end
    
    def user_match
        attempts = 0
        loop do
            puts "Guess the 4 values:"
            p @@full_colors
            choices = gets.chomp.split(" ")
            puts nil
            if choices == @colors
                puts nil
                puts "You won!"
                p @colors
                again
                break
            else
                iss_arr = []
                issues = 0
                if choices.length != @colors.length
                    puts "Wrong number of arguments"
                else
                    choices.each_with_index do |val, idx|
                        if @colors.index(val) == choices.index(val)
                            iss_arr.push("Correct!")
                        elsif !(@colors.include?(val))
                            iss_arr.push("Wrong value")
                            issues += 1
                        elsif @colors.index(val) != choices.index(val)
                            iss_arr.push("Wrong index")
                            issues += 1
                        end
                    end
                    attempts += 1
                    if attempts == 12
                        puts "It's over!"
                        again
                        break
                    end
                    puts "#{issues} detected (and shuffled) issue(s)"
                    p iss_arr.shuffle
                    puts "You have #{12 - attempts} more attempt(s) left"
                    puts "Last choices: #{choices}"
                    puts nil
                end
            end
        end
    end
    
    def computer_match
        attempts = 0
        reg_choices = []
        loop do
            smp_choices = @@full_colors.shuffle.take(4)
            issues = 0
            iss_arr = []
            if reg_choices == @colors
                puts nil
                puts "Computer won!"
                p @colors
                again
                break
            else
                smp_choices.each_with_index do |val, idx|
                    if val == @colors[idx]
                        iss_arr.push("Correct")
                        reg_choices[idx] = val
                    elsif !(@colors.include?(val))
                        iss_arr.push("Wrong value")
                        issues += 1
                    elsif smp_choices.index(val) != @colors.index(val)
                        iss_arr.push("Wrong index")
                        issues += 1
                    end
                end
                attempts += 1
                if attempts == 12
                    puts "It's over!"
                    again
                    break
                end
                puts "#{issues} detected (and shuffled) issue(s)"
                p iss_arr
                puts "Computer has #{12 - attempts} more attempt(s) left"
                puts "Sample choices: #{smp_choices}"
                puts "Registered choices: #{reg_choices}"
                puts nil
            end
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

end

Mastermind.new.play