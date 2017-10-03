class ConsoleIO
  def new_game
    puts "Welcome to hangman!"
  end

  def new_game?
    puts "Do you want to play again? (y/n)"
    return get == "y"
  end

  def status (cur, lives, guessed)
    puts "Current guess: "
    cur.each{|x|print x==nil ? "_" : x}
    puts ""
    puts "Lives remaining: "
    puts lives
    puts "Letters guessed: "
    guessed.each{|x| print x + " " unless x == nil}
    puts ""

  end

  def already_guessed
    puts "Already guessed, try again"
  end

  def mult_letter
    puts "Please only input one letter, try again"
  end

  def non_alpha
    puts "Please only input letters"
  end

  def enter_guess
    puts "Enter new guess: "
  end

  def win(word)
    puts "You win!"
    puts "The word was "<<word
    true
  end

  def lose(word)
    puts "You lose!"
    puts "The word was "<<word
    true
  end
  def get
    gets.chomp
  end

end