require_relative '../lib/hangman'
require_relative '../lib/console_io'
# :nodoc:
class PlayHangman
  attr_reader :io_controller, :hangman

  def play
    loop do
      new_game
      game_loop
      hangman.won? ? won! : lost!
      break unless io_controller.new_game?
    end
  end

  def new_game
    @io_controller = ConsoleIO.new
    @hangman = Hangman.new(random_word(create_word_array))
  end

  def game_loop
    until hangman.lost? || hangman.won?
      io_controller.status(hangman.guess_state, hangman.lives_remaining,
                           hangman.guessed)
      make_guess
    end
  end

  def lost!
    io_controller.lost!(hangman.word)
  end

  def won!
    io_controller.won!(hangman.word)
  end

  def make_guess
    guess = ''
    loop do
      guess = io_controller.guess_prompt
      result = hangman.guess_error?(guess)
      break unless result
      io_controller.error(result)
    end
    hangman.guessed_add guess
  end

  def random_word(words)
    words.sample.chomp
  end

  def create_word_array
    word_array = []
    path = File.dirname(__FILE__)
    file = path << '/dictionary.txt'
    File.foreach(file) { |line| word_array << line }
    word_array
  end
end
