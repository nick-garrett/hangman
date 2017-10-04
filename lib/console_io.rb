# :nodoc:
class ConsoleIO
  def new_game
    puts 'Welcome to hangman!'
  end

  def new_game?
    puts 'Do you want to play again? (y/n)'
    input == 'y'
  end

  def status(cur_guessed_word, lives_left, guessed_letters)
    puts 'Current guess: '
    cur_guessed_word.each { |x| print x.nil? ? '_' : x }
    puts ''
    puts 'Lives remaining: '
    puts lives_left
    puts 'Letters guessed: '
    guessed_letters.each { |x| print x + ' ' unless x.nil? }
    puts ''
  end

  def guess_prompt
    puts 'Enter new guess: '
    input
  end

  def won(word)
    puts 'You win!'
    puts "The word was #{word}"
  end

  def lost(word)
    puts 'You lose!'
    puts "The word was #{word}"
  end

  def input
    gets.chomp
  end

  def display_error(msg)
    puts msg
  end
end
