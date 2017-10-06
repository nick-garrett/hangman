# :nodoc:
class Hangman
  attr_accessor :guessed, :word
  attr_reader :io_controller, :total_lives

  def self.random_word(words)
    words.sample.chomp
  end

  def self.create_word_array
    file = File.dirname(__FILE__) << '/dictionary.txt'
    File.readlines(file)
  end

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

  def game_over?
    lost? || won?
  end

  def lives_remaining
    total_lives - (guessed - word).size
  end

  def masked_word
    word.map { |x| x if guessed.include? x }
  end

  def end_message
    won? ? 'You won!' : 'You lost!'
  end

  private

  def won?
    (word - guessed).size.zero?
  end

  def lost?
    lives_remaining.zero?
  end
end
