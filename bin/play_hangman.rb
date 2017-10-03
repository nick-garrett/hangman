#!/usr/bin/env ruby
require_relative 'hangman'
require_relative 'console_io'
class PlayHangman

	def play(io_controller = ConsoleIO.new, type = "console", lives=10, words=nil)
		loop do
			h = Hangman.new(random_word(words==nil? create_word_array : words),lives)

			while true do
				io_controller.status(h.cur_guess, h.lives_remaining, h.guessed)

				while true do
					io_controller.enter_guess
					result =  h.check_guess io_controller.get
					break if result == ""
					io_controller.error(result)
				end

				break if h.lose?
				break if h.win?
			end

			io_controller.win(h.word) if h.win?
			io_controller.lose(h.word) if h.ose?

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