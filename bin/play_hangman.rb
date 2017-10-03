#!/usr/bin/env ruby
require_relative '../lib/hangman'
require_relative '../lib/console_io'
class PlayHangman

	def play
		@NUM_LIVES = 10
		loop do
			io_controller = ConsoleIO.new
			h = Hangman.new(random_word(create_word_array),@NUM_LIVES)
			while true do
				io_controller.status(h.cur_guess, h.lives_remaining, h.guessed)
				while true do
					io_controller.enter_guess
					result =  h.check_guess io_controller.get
					break if result == ""
					io_controller.error(result)
				end
				break if h.check_lose?
				break if h.check_win?
			end
			if h.check_win?
				io_controller.win(h.word)
			else
				io_controller.lose(h.word)
			end
			break if ! io_controller.new_game?
		end 
	end

	def random_word(words)
    	words[rand(words.size)].chomp
  	end

	
	def create_word_array
		w = Array.new
		File.foreach(File.dirname(__FILE__)<<'/../lib/dictionary.txt').each { |word| w << word }
		w
	end
end

#PlayHangman.new.play