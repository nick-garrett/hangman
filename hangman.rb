#require "ruby_hangman/version"
class Game
  $TOTAL_LIVES = 10
  def new_game
  	puts "Welcome to hangman! Input a command, or type 'help' for more info."
    $io_type = ConsoleIO.new
  	choose_word
    $cur_guess = ""
    $word.size.times {$cur_guess << "_"}
    $lives_remaining = $TOTAL_LIVES
    $guessed = Array.new
  	game_loop
  end

  def make_guess
    $io_type.put "Enter new guess: "
    check_guess ($io_type.get)
  end

  def update_guess (char)
    (0 ... $word.size).each{|i| $cur_guess[i] = $word[i] if $word[i] == char}
  end

  def decrease_lives
    $lives_remaining -= 1
  end

  def check_guess (guess)
    if $guessed.include? guess
      $io_type.put "Already guessed, try again"
      return make_guess
    elsif guess.size > 1
      $io_type.put "Please only input one letter, try again"
      return make_guess
    elsif $word.include? guess
      update_guess guess
    else
      decrease_lives
    end
    $guessed.push guess
    return guess
  end

  def check_win?
    !$cur_guess.include? "_"
  end

  def check_lose?
    $lives_remaining == 0
  end

  def game_loop
  	while true do 
      $io_type.status($cur_guess, $lives_remaining)
      
      make_guess
      break if check_lose?
      break if check_win?
  	end
    if check_win?
      $io_type.win 
    else
      $io_type.lose
    end
    $io_type.put "Do you want to play again?(y/n)"
    new_game if $io_type.get == "y"
  end

  def choose_word
  	$word = $words[rand($words.size)]
  	#puts $word
  end
end

class ConsoleIO
  def status (cur, lives)
      put "Current guess: "
      put cur
      put "Lives remaining: "
      put lives
      
    end
  def win
    put "You win!"
  end

  def lose
    put "You lose!"
  end

  def get
    gets.chomp
  end

  def put (str)
    puts str
  end
end

  	$words = Array.new
    File.foreach('dictionary.txt').each { |word| $words << word }
    game = Game.new
    game.new_game

