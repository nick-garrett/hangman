require_relative 'console_io'
class Hangman
  @TOTAL_LIVES = 10

  def initialize(word = random_word(create_word_array), io_controller = ConsoleIO.new, lives = 10)
    @io_controller = io_controller
    @io_controller.new_game 
    @guessed = Array.new
    @word = word
    @TOTAL_LIVES = lives
  end

  def create_word_array
    w = Array.new
    File.foreach(File.dirname(__FILE__)<<'/dictionary.txt').each { |word| w << word }
    w
  end

  def new_game?
    @io_controller.new_game?
  end

  def make_guess
    @io_controller.enter_guess while !check_guess (@io_controller.get.downcase)
  end

  def check_guess (guess)
    if @guessed.include? guess
      @io_controller.already_guessed 
      return false
    elsif guess.size > 1
      @io_controller.mult_letter 
      return false
    elsif !guess.match(/^[[:alpha:]]$/)
      @io_controller.non_alpha
      return false
    end
    @guessed.push guess
    return true
  end

  def check_win?
    return @io_controller.win(@word) if !(cur_guess.include? nil)
    false
  end

  def check_lose?
    return @io_controller.lose(@word) if lives_remaining == 0
    false
  end

  def lives_remaining
    @TOTAL_LIVES - @guessed.count{|x|!@word.include? x}
  end

  def cur_guess
    to_return = Array.new(@word.size)
    (0 ... @word.size).each{|i| to_return[i] = @word[i] if @guessed.include? @word[i]}
    to_return
  end

  def random_word(words)
    words[rand(words.size)].chomp
  end


  def game_loop
    while true do
      @io_controller.status(cur_guess, lives_remaining, @guessed)
      make_guess
      break if check_lose?
      break if check_win?
    end
  end


#Methods only used for testing
  def set_word(word)
    @word = word
  end

  def set_guessed(guessed)
    @guessed = guessed
  end
end