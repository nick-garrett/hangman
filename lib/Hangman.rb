require_relative 'console_io'
class Hangman
  attr_accessor :word, :guessed
  attr_reader :io_controller

  def initialize(word = random_word(create_word_array), lives = 10)
    @guessed = Array.new
    @word = word
    @TOTAL_LIVES = lives
  end

  def create_word_array
    w = Array.new
    File.foreach(File.dirname(__FILE__)<<'/dictionary.txt').each { |word| w << word }
    w
  end

  def check_guess (guess)
    if guessed.include? guess
      return "Already guessed, try again"
    elsif guess.size > 1
      return "Please only input one letter, try again"
    elsif !guess.match(/^[[:alpha:]]$/)
      return "Please only input letters"
    end
    guessed.push guess
    return ""
  end

  def check_win?
    !(cur_guess.include? nil)
  end

  def check_lose?
    lives_remaining == 0
  end

  def lives_remaining
    @TOTAL_LIVES - guessed.count{|x|!word.include? x}
  end

  def cur_guess
    to_return = Array.new(word.size)
    (0 ... word.size).each{|i| to_return[i] = word[i] if guessed.include? word[i]}
    to_return
  end

  def random_word(words)
    words[rand(words.size)].chomp
  end

end