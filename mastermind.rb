class Mastermind
  def initialize
    @computer = Computer.new
    @player = Player.new
    @game_mode = ""
  end

  def intro
    puts "If you've never played Mastermind, a game where you have to guess your opponent's secret code within a certain number of turns (like hangman but with numbers)."
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
    puts "Matches means that your guess has a correct digit in a correct place, while Wrong Position means that your guess has a correct digit but in the wrong place"
    puts "You have 12 rounds to guess the code. Good luck! \n\n\n"
    player_guess_code()
  end

  def code_maker
    puts "\n\n\n\nPlease input your secret four digit code: "
    code = @player.player_input_code()
    i = 12
    12.times do
      return if @computer.player_code_guessed

      puts "\nComputer has #{i} guesses left\n\n"
      @computer.code_guess_algorithm_advanced(code)
      i -= 1
    end 
  end 

  def player_guess_code
    round = 1
    12.times do
      return if @code_guessed 
      puts "Round #{round}:"
      attempt = @player.player_input_guess()
      code_to_break = @computer.code_to_break_array
      if attempt == code_to_break
        puts "You guessed the code!"
        puts "Your guess: #{attempt}"
        puts "The code: #{code_to_break}"
        @code_guessed = true
      else
        @computer.compare_code(attempt, code_to_break, true)
        round += 1
      end
    end
    return if @code_guessed
    puts "You have lost the game!"
    puts "The code was: #{@computer.code_to_break_array}"
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

  def player_input_code
    @code_guess = gets.chomp
    until @code_guess.match?(/^[1-6]{4}$/)
      puts "\nPlease input a valid code\nTry again..."
      @code_guess = gets.chomp
    end 
    @code_guess_array = @code_guess.split("")
  end
end

class Computer
  attr_accessor :code_to_break_array, :code_guessed, :player_code_guessed
  NUMBERS = ["1", "2", "3", "4", "5", "6"]
  @player_code_guessed = false
  def initialize
    @code_to_break_array = [NUMBERS.sample, NUMBERS.sample, NUMBERS.sample, NUMBERS.sample]
    @code_guessed = false
    @code_pool = []
    NUMBERS.each { |a| NUMBERS.each { |b| NUMBERS.each { |c| NUMBERS.each { |d| @code_pool.push([a, b, c, d]) } } } }
  end

  def code_guess_algorithm_advanced(code)
    code_guess = @code_pool[rand(@code_pool.length)]
    puts "The computers guess is #{code_guess}"
    if code_guess == code
      puts 'The computer guessed your code!'
      @player_code_guessed = true
    else
      compare_code(code, code_guess,)
      puts "\nPress enter for next computer guess"
      gets.chomp
    end
    @code_pool.select! { |c| compare_code(code, code_guess) ==compare_code(c, code_guess) }
  end

  def compare_code(code_array, code_to_compare, should_print = false)
   code_to_compare_duplicate = code_to_compare.dup
   code_array_duplicate = code_array.dup
   matches = 0
   partials = 0
   (code_array_duplicate.size - 1).downto(0) do |i| 
    if code_array_duplicate[i] == code_to_compare_duplicate[i]
      matches += 1
      code_array_duplicate.delete_at(i)
      code_to_compare_duplicate.delete_at(i)
    end
   end
   (code_array_duplicate.size - 1).downto(0) do |i|
     if code_to_compare_duplicate.include?(code_array_duplicate[i])
        partials += 1
        code_array_duplicate.delete_at(i)
        code_to_compare_duplicate.delete(code_array_duplicate[i])
     end
    end
      return if @code_guessed
      puts "Matches: #{matches}" if should_print
      puts "Partials: #{partials}" if should_print
      [matches.to_s, partials.to_s]
  end
end
end

Mastermind.new.intro