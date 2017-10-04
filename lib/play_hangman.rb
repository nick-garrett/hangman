#!/usr/bin/env ruby
require_relative '../lib/hangman'
require_relative '../lib/console_io'
class PlayHangman
	attr_reader :io_controller, :hangman

	def play
		@NUM_LIVES = 10
		loop do
			@io_controller = ConsoleIO.new
			@hangman = Hangman.new(random_word(create_word_array),@NUM_LIVES)
			until hangman.lose? || hangman.win?
				io_controller.status(hangman.cur_guess, hangman.lives_remaining, hangman.guessed)
				hangman.guessed.push get_valid_guess
			end
			hangman.win? ? io_controller.win(hangman.word) : io_controller.lose(hangman.word)
			break unless io_controller.new_game?
		end  
	end

	def get_valid_guess
		loop do
			io_controller.enter_guess
			guess = io_controller.get_input
			result =  hangman.check_guess(guess)
			return guess if result == ""
			io_controller.error(result)
		end
	end

	def random_word(words)
		words[rand(words.size)].chomp
	end

	
	def create_word_array
		word_array = Array.new
		File.foreach(File.dirname(__FILE__)<<'/../lib/dictionary.txt').each { |word| word_array << word }
		word_array
	end
end