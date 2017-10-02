require_relative 'ConsoleIO'
class Hangman
  $TOTAL_LIVES = 10

  def initialize
    new_game(create_word_array)
  end

  def initialize(a,b)
    #does nothing, just for testing...
  end

  def create_word_array
    w = Array.new
    File.foreach(File.dirname(__FILE__)<<'/dictionary.txt').each { |word| w << word }
    w
  end


  def new_game(words)
    $io_controller = ConsoleIO.new
    $io_controller.new_game 
  	choose_word(words)
    $guessed = Array.new
  	game_loop
  end

  def make_guess
    $io_controller.enter_guess while !check_guess ($io_controller.get.downcase)
  end

  def check_guess (guess)
    if $guessed.include? guess
      $io_controller.already_guessed 
      return false
    elsif guess.size > 1
      $io_controller.mult_letter 
      return false
    elsif !guess.match(/^[[:alpha:]]$/)
      $io_controller.non_alpha
      return false
    end
    $guessed.push guess
    return true
  end

  def check_win?
    !cur_guess.include? nil
  end

  def check_lose?
    lives_remaining == 0
  end

  def lives_remaining
    $TOTAL_LIVES - $guessed.count{|x|!$word.include? x}
  end

  def cur_guess
    to_return = Array.new($word.size)
    (0 .. $word.size).each{|i| to_return[i] = $word[i] if $guessed.include? $word[i]}
    to_return
  end



  def game_loop
  	while true do 
      $io_controller.status(cur_guess, lives_remaining, $guessed)
      
      make_guess
      break if check_lose?
      break if check_win?
  	end
    if check_win?
      $io_controller.win($word)
    else
      $io_controller.lose($word)
      puts $word
    end
    new_game if $io_controller.new_game?
  end


  def choose_word(words)
  	$word = words[rand(words.size)].chomp
  end

end