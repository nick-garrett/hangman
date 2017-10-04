require_relative '../lib/hangman'
require_relative '../lib/console_io'
# :nodoc:
class PlayHangman
  attr_reader :io_controller, :hangman

  def play
    loop do
      new_game
      game_loop
      hangman.won? ? won : lost
      break unless io_controller.new_game?
    end
  end

  def new_game
    @io_controller = ConsoleIO.new
    @hangman = Hangman.new(random_word(create_word_array))
  end

  def game_loop
    until hangman.lost? || hangman.won?
      io_controller.status(hangman.cur_guessed_word, hangman.lives_remaining,
                           hangman.guessed)
      make_valid_guess
    end
  end

  def lost
    io_controller.lost(hangman.word.join)
  end

  def won
    io_controller.won(hangman.word.join)
  end

  def make_valid_guess
    guess = io_controller.guess_prompt
    loop do
      error = hangman.validate_guess(guess)
      break unless error
      io_controller.display_error(error)
      guess = io_controller.guess_prompt
    end
    hangman.add_to_guessed guess
  end

  def random_word(words)
    words.sample.chomp
  end

  def create_word_array
    path = File.dirname(__FILE__)
    file = path << '/dictionary.txt'
    File.foreach(file).map { |line| line }
  end
end
