# :nodoc:
class Hangman
  attr_accessor :word, :guessed
  attr_reader :io_controller, :total_lives

  def initialize(word, lives = 10)
    @guessed = []
    @word = word
    @total_lives = lives
  end

  def guess_error?(guess)
    if guessed.include? guess
      'Already guessed, try again'
    elsif guess.size > 1
      'Please only input one letter, try again'
    elsif !guess.match(/^[[:alpha:]]$/)
      'Please only input letters'
    else
      nil
    end
  end

  def guessed_add(char)
    guessed.push char
  end

  def won?
    !guess_state.include? nil
  end

  def lost?
    lives_remaining.zero?
  end

  def lives_remaining
    total_lives - guessed.count { |x| !word.include?(x) }
    total_lives - (guessed - word.chars).count
  end

  def guess_state
    word.chars.map {|x| x if guessed.include? x }
  end
end
