require_relative '../lib/hangman'
require_relative '../lib/console_io'
describe Hangman do
	let(:h) { Hangman.new() }
	let(:word) { "test"}

	describe 'create_word_array' do
		it 'should have 370101 elements' do
			expect(h.create_word_array.size).to eq 370101
		end
	end

	describe 'check_guess' do
		it 'should not accept multiple characters' do
			expect(h.check_guess "aa").to eq false
		end

		it 'should not accept guesses already made' do
			h.check_guess "a"
			expect(h.check_guess "a").to eq false
		end

		it 'should not accept non-alphabetic guesses' do
			expect(h.check_guess "1").to eq false
			expect(h.check_guess "!").to eq false
			expect(h.check_guess " ").to eq false
		end

		it 'should accept other guesses' do
			expect(h.check_guess "a").to eq true
			expect(h.check_guess "b").to eq true
			expect(h.check_guess "c").to eq true
		end
	end

	describe 'check_win?' do
		it 'should return true when all of the letters in the word are also in the guessed array' do
			h.set_word(word)
			h.set_guessed ["t", "e", "s"]
			expect(h.check_win?).to eq true
		end

		it 'should return false when some of the letters in the word are in the guessed array' do
			h.set_word(word)
			h.set_guessed ["t", "e"]
			expect(h.check_win?).to eq false
		end

		it 'should return false when no letters in the word are in the guessed array' do
			h.set_word(word)
			h.set_guessed  Array.new
			expect(h.check_win?).to eq false
		end

		it 'should return false when combination of some letters in the word and other letters are in the guessed array' do
			h.set_word(word)
			h.set_guessed  ["t", "e", "a", "q"]
			expect(h.check_win?).to eq false
		end

		it 'should return true when all letters from the word and some others are in the guessed array' do
			h.set_word(word)
			h.set_guessed  ["t", "e", "s", "q", "m"]
			expect(h.check_win?).to eq true
		end
	end

	describe 'check_lose?' do
		it 'should return true when 0 lives' do
			h.set_word(word)
			h.set_guessed ["a","b","c","d","f","g","h","i","j","k"]
			expect(h.check_lose?).to eq true
		end

		it 'should return false when lives greater than 0' do
			h.set_word(word)
			h.set_guessed  ["a","b","c","d"]
			expect(h.check_lose?).to eq false
		end
	end

	describe 'random_word' do
		it 'should choose the word "test"' do
			words = [word]
			w = h.random_word(words)
			expect(w).to eq "test"
		end

		it "should strip newline character from the word" do
			words = ["test\n"]
			w = h.random_word(words)
			expect(w.include? "\n").to eq false
		end

		it "should choose one of the words from the array" do
			words = %w(one two three four)
			word = h.random_word(words)
			expect(words.include? word).to eq true
		end
	end

	describe 'cur_guess' do
		it 'should have nil elements at any point where the letter in the word is not in guessed' do
			h.set_word(word)
			h.set_guessed  Array.new
			expect(h.cur_guess).to eq [nil, nil, nil, nil]

			h.set_guessed  [nil, "e", nil, nil]
			expect(h.cur_guess).to eq [nil, "e", nil, nil]
		end


		it 'should have char elements at any point where the letter in the word is in guessed' do
			h.set_word(word)
			h.set_guessed ["t", "s", "e"]
			expect(h.cur_guess).to eq ["t", "e", "s", "t"]
		end
	end

	describe 'lives_remaining' do
		it 'should equal total lives minus number of guesses not in the word' do
			h.set_word(word)
			h.set_guessed  ["t", "s", "e"]
			expect(h.lives_remaining).to eq 10

			h.set_guessed ["t", "s", "q", "w"]
			expect(h.lives_remaining).to eq 8

			h.set_guessed  Array.new
			expect(h.lives_remaining).to eq 10

			h.set_guessed  ["a","b","c","d","e","f"]
			expect(h.lives_remaining).to eq 5
		end
	end
end

describe ConsoleIO do

end