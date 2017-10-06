# :nodoc:
class ConsoleIO
  def new_game
    puts 'Welcome to hangman!'
  end

  def new_game?
    puts 'Do you want to play again?'
    input == 'y'
  end

  def status(masked_word, lives_left, guessed_letters)
    puts 'Current guess: '
    masked_word.each { |x| print x.nil? ? '_' : x }
    puts ''
    puts 'Lives remaining: '
    puts lives_left
    puts 'Letters guessed: '
    guessed_letters.each { |x| print x + ' ' }
    puts ''
  end

  def guess_prompt
    puts 'Enter new guess: '
    input
  end

  def end_message(msg, word)
    puts msg
    puts "The word was #{word.join}"
  end

  def display_error(msg)
    puts msg
  end

  private

  def input
    $stdin.gets.chomp.downcase
  end
end
