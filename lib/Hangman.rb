class Hangman
  attr_accessor :word, :guessed
  attr_reader :io_controller

  def initialize(word, lives = 10)
    @guessed = Array.new
    @word = word
    @TOTAL_LIVES = lives
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

  def win?
    !(cur_guess.include? nil)
  end

  def lose?
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

end