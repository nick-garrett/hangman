require_relative '../lib/hangman'
require_relative '../lib/console_io'
# :nodoc:
class PlayHangman
  attr_reader :io_controller, :hangman

  def new_game
    @io_controller = ConsoleIO.new
    @hangman = Hangman.new(random_word(create_word_array), @num_lives)
  end

  def game_loop
    until hangman.lose? || hangman.win?
      io_controller.status(hangman.cur_guess, hangman.lives_remaining,
                           hangman.guessed)
      valid_guess
    end
  end

  def play
    @num_lives = 10
    loop do
      new_game
      game_loop
      hangman.win? ? io_controller.win(hangman.word) : io_controller.lose(hangman.word)
      break unless io_controller.new_game?
    end
  end

  def valid_guess
    guess = ''
    loop do
      io_controller.enter_guess
      guess = io_controller.input
      result = hangman.check_guess(guess)
      break if result == ''
      io_controller.error(result)
    end
    hangman.guessed.push guess
  end

  def random_word(words)
    words[rand(words.size)].chomp
  end

  def create_word_array
    word_array = []
    path = File.dirname(__FILE__)
    file = path << '/../lib/dictionary.txt'
    File.foreach(file).each { |line| word_array << line }
    word_array
  end
end
