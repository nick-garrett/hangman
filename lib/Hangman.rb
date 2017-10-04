class Hangman
  attr_accessor :word, :guessed
  attr_reader :io_controller, :total_lives

  def initialize(word, lives = 10)
    @guessed = Array.new
    @word = word
    @total_lives = lives
  end

  def check_guess(guess) 
    if guessed.include? guess
      "Already guessed, try again"
    elsif guess.size > 1
      "Please only input one letter, try again" 
    elsif !guess.match(/^[[:alpha:]]$/)
      "Please only input letters" 
    else
      ""
    end
  end

  def win?
    !cur_guess.include? nil
  end

  def lose?
    lives_remaining == 0
  end

  def lives_remaining
    total_lives - guessed.count { |x| !word.include?(x) }
  end

  def cur_guess
    guess_state = Array.new(word.size)
    (0...word.size).each { |i| guess_state[i] = word[i] if guessed.include? word[i] }
    guess_state
  end

end