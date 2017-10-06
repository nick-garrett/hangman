require_relative 'hangman'
require_relative 'console_io'
# :nodoc:
class PlayHangman
  attr_reader :ui, :hangman

  def play
    loop do
      new_game!(ConsoleIO.new, Hangman.new(@word || Hangman.random_word(Hangman.create_word_array)))
      game_loop
      end_message
      break unless new_game?
    end
  end

  private

  def new_game?
    ui.new_game?
  end

  def new_game!(ui, hangman)
    @ui = ui
    @hangman = hangman
    ui.new_game
  end

  def game_loop
    until hangman.game_over?
      ui.status(hangman.masked_word, hangman.lives_remaining,
                hangman.guessed)
      make_guess
    end
  end

  def end_message
    ui.end_message(hangman.end_message, hangman.word)
  end

  def make_guess
    guess = ui.guess_prompt
    error = hangman.validate_guess(guess)
    error ? handle_guess_error(error) : hangman.add_to_guessed(guess)
  end

  def handle_guess_error(error)
    ui.display_error(error)
    make_guess
  end
end
