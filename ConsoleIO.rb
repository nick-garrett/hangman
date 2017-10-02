class ConsoleIO
  def new_game
    puts "Welcome to hangman!"
  end

  def new_game?
    puts "Do you want to play again? (y/n)"
    return get == "y"
  end

  def status (cur, lives)
    puts "Current guess: "
    puts cur
    puts "Lives remaining: "
    puts lives

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

  def win
    puts "You win!"
  end

  def lose
    puts "You lose!"
  end
  def get

    gets.chomp
  end

end