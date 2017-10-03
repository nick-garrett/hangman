require_relative '../lib/hangman'

describe Hangman do
	let(:hangman) { Hangman.new("test") }
	let(:word) { "test"}
	before(:each) do
			hangman.word = word 
		end


	describe 'check_guess' do
		it 'should not accept multiple characters' do
			expect(hangman.check_guess "aa").not_to eq ""
		end

		it 'should not accept guesses already made' do
			hangman.check_guess "a"
			expect(hangman.check_guess "a").not_to eq ""
		end

		it 'should not accept non-alphabetic guesses' do
			expect(hangman.check_guess "1").not_to eq ""
			expect(hangman.check_guess "!").not_to eq ""
			expect(hangman.check_guess " ").not_to eq ""
		end

		it 'should accept other guesses' do
			expect(hangman.check_guess "a").to eq ""
			expect(hangman.check_guess "b").to eq ""
			expect(hangman.check_guess "c").to eq ""
		end
	end

	describe 'win?' do
		it 'should return true when all of the letters in the word are also in the guessed array' do
			hangman.guessed = ["t", "e", "s"]
			expect(hangman.win?).to eq true
			#be_truthy
			#be_falsy
		end

		it 'should return false when some of the letters in the word are in the guessed array' do
			hangman.guessed = ["t", "e"]
			expect(hangman.win?).to eq false
		end

		it 'should return false when no letters in the word are in the guessed array' do
			hangman.guessed = Array.new 
			expect(hangman.win?).to eq false
		end

		it 'should return false when combination of some letters in the word and other letters are in the guessed array' do
			hangman.guessed = ["t", "e", "a", "q"]
			expect(hangman.win?).to eq false
		end

		it 'should return true when all letters from the word and some others are in the guessed array' do
			hangman.guessed = ["t", "e", "s", "q", "m"]
			expect(hangman.win?).to eq true
		end
	end

	describe 'lose?' do
		it 'should return true when 0 lives' do
			hangman.guessed = ["a","b","c","d","f","g","h","i","j","k"]
			expect(hangman.lose?).to eq true
		end

		it 'should return false when lives greater than 0' do
			hangman.guessed = ["a","b","c","d"]
			expect(hangman.lose?).to eq false
		end
	end


	describe 'cur_guess' do
		it 'should have nil elements at any point where the letter in the word is not in guessed' do
			hangman.guessed = Array.new
			expect(hangman.cur_guess).to eq [nil, nil, nil, nil]

			hangman.guessed = [nil, "e", nil, nil]
			expect(hangman.cur_guess).to eq [nil, "e", nil, nil]
		end

		it 'should have char elements at any point where the letter in the word is in guessed' do
			hangman.guessed = ["t", "s", "e"]
			expect(hangman.cur_guess).to eq ["t", "e", "s", "t"]
		end
	end

	describe 'lives_remaining' do
		it 'should equal total lives minus number of guesses not in the word' do
			hangman.guessed = ["t", "s", "e"]
			expect(hangman.lives_remaining).to eq 10

			hangman.guessed = ["t", "s", "q", "w"]
			expect(hangman.lives_remaining).to eq 8

			hangman.guessed = Array.new
			expect(hangman.lives_remaining).to eq 10

			hangman.guessed = ["a","b","c","d","e","f"]
			expect(hangman.lives_remaining).to eq 5
		end
	end
end
