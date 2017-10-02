require_relative 'ConsoleIO'
class Game
  $TOTAL_LIVES = 10

  def initialize
    $words = Array.new
    File.foreach('dictionary.txt').each { |word| $words << word }
    new_game
  end


  def new_game
    $io_controller = ConsoleIO.new
    $io_controller.new_game 
  	choose_word
    $cur_guess = ""
    $word.size.times {$cur_guess << "_"}
    $lives_remaining = $TOTAL_LIVES
    $guessed = Array.new
  	game_loop
  end

  def make_guess
    $io_controller.enter_guess 
    check_guess ($io_controller.get)
  end

  def update_guess (char)
    (0 ... $word.size).each{|i| $cur_guess[i] = $word[i] if $word[i] == char}
  end

  def decrease_lives
    $lives_remaining -= 1
  end

  def check_guess (guess)
    if $guessed.include? guess
      $io_controller.already_guessed 
      return make_guess
    elsif guess.size > 1
      $io_controller.mult_letter 
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
      $io_controller.status($cur_guess, $lives_remaining)
      
      make_guess
      break if check_lose?
      break if check_win?
  	end
    if check_win?
      $io_controller.win 
    else
      $io_controller.lose
    end
    new_game if $io_controller.new_game?
  end


  def choose_word
  	$word = $words[rand($words.size)]
  	#puts $word
  end
end

Game.new

