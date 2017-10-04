# :nodoc:
class ConsoleIO
  def new_game
    puts 'Welcome to hangman!'
  end

  def new_game?
    puts 'Do you want to play again? (y/n)'
    input == 'y'
  end

  def status(cur_guess, lives_left, guessed_letters)
    puts 'Current guess: '
    cur_guess.each { |x| print x.nil? ? '_' : x }
    puts ''
    puts 'Lives remaining: '
    puts lives_left
    puts 'Letters guessed: '
    guessed_letters.each { |x| print x + ' ' unless x.nil? }
    puts ''
  end

  def enter_guess
    puts 'Enter new guess: '
  end

  def win(word)
    puts 'You win!'
    puts "The word was #{word}"
  end

  def lose(word)
    puts 'You lose!'
    puts "The word was #{word}"
  end

  def input
    gets.chomp
  end

  def error(msg)
    puts msg
  end
end
