require_relative '../lib/hangman'
require_relative '../lib/console_io'
loop do
	h = Hangman.new
	h.game_loop
	break if ! h.new_game?
end