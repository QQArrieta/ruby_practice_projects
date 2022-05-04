class Mastermind
  def initialize
    @computer = Computer.new
    @player = Player.new
    @game_mode = ""
  end

  def intro
    puts "\nIf you've never played Mastermind, a game where you have to guess your opponent's secret code within a certain number of turns (like hangman but with numbers)."
    puts "Decide whether you want to be the code-maker or code-breaker"
    decide_game_mode()
  end

  def decide_game_mode
    puts "Enter 'make' to be the code-maker, enter 'break' to be the code-breaker"
    @game_mode = gets.chomp.downcase
    until @game_mode.match?(/^make$|^break$/)
      puts "\nPlease choose whether you want to guess the code or create by typing 'make' or 'break'\nTry again..."
      @game_mode = gets.chomp.downcase
    end 
    if @game_mode == "make"
      code_maker()
    else
      code_breaker()
    end
  end

  def code_breaker
    puts "\n\n\n\nThe computer has generated a random 4 digit code from this set: [1, 2, 3, 4, 5, 6]"
    puts "Your, goal is to guess the code 4 digits at a time. The computer will then rate your guesses."
    puts "✓ means that your guess has a correct digit in a correct place, while ◯ means that your guess has a correct digit but in the wrong place"
    puts "The order of the ✓'s and ◯'s have no indication to which digit they mean"
    puts "You have 12 rounds to guess the code. Good luck! \n\n\n"
    player_guess_code()
    
  end

  def player_guess_code
    round = 1
    12.times do
      return if @computer.code_guessed

      puts "Round #{round}:"
      attempt = @player.player_input_guess()
      p attempt
      @computer.compare_code(attempt)
      round += 1
    end
    puts "You have lost the game!"
    puts "The code was: #{@computer.code_to_break_array}"
  end 

end

class Player
  attr_reader :code_guess_array
  def initialize
    @code_guess = ""
    @code_guess_array = []
  end

  def player_input_guess
    print "Please input your guess: "
    @code_guess = gets.chomp
    until @code_guess.match?(/^[1-6]{4}$/)
      puts "\nPlease input a valid guess\nTry again..."
      @code_guess = gets.chomp
    end 
    @code_guess_array = @code_guess.split("")
  end
end

class Computer
  attr_reader :code_to_break_array, :code_guessed
  NUMBERS = ["1", "2", "3", "4", "5", "6"]
  def initialize
    @code_to_break_array = [NUMBERS.sample, NUMBERS.sample, NUMBERS.sample, NUMBERS.sample]
    @code_guessed = false
  end

  def compare_code(code_array)
    if code_array == @code_to_break_array
      puts "You guessed the code!"
      puts "Your guess: #{code_array}"
      puts "The code: #{@code_to_break_array}"
      @code_guessed = true
    else
      code_to_break_duplicate = @code_to_break_array.dup
      code_array_duplicate = code_array.dup
      matches = 0
      wrong_position = 0
      (code_array_duplicate.size - 1).downto(0) do |i| 
      if code_array_duplicate[i] == code_to_break_duplicate[i]
        matches += 1
        code_array_duplicate.delete_at(i)
        code_to_break_duplicate.delete_at(i)
      end
      end
      (code_array_duplicate.size - 1).downto(0) do |i|
      if code_to_break_duplicate.include?(code_array_duplicate[i])
        wrong_position += 1
        code_array_duplicate.delete_at(i)
      end
      end
    end
      puts "Matches: #{matches}"
      puts "Wrong position: #{wrong_position}"

  end

end
Mastermind.new.intro