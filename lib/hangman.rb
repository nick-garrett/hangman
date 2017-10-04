# :nodoc:
class Hangman
  attr_accessor :guessed
  attr_reader :word, :io_controller, :total_lives

  def initialize(word, lives = 10)
    @guessed = []
    @word = word.chars
    @total_lives = lives
  end

  def validate_guess(guess)
    if guessed.include? guess
      'Already guessed, try again'
    elsif guess.size > 1
      'Please only input one letter, try again'
    elsif !guess.match(/^[[:alpha:]]$/)
      'Please only input letters, try again'
    else
      false
    end
  end

  def add_to_guessed(char)
    guessed.push char
  end

  def won?
    (word - guessed).count.zero?
  end

  def lost?
    lives_remaining.zero?
  end

  def lives_remaining
    total_lives - (guessed - word).count
  end

  def cur_guessed_word
    word.map { |x| x if guessed.include? x }
  end
end
