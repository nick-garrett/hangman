require_relative '../lib/Hangman'
require_relative '../lib/ConsoleIO'
describe Hangman do
	describe 'create_word_array' do
		it 'should have  elements'
	end

	describe 'choose_word' do
		before each do
			h = Hangman.new(1,2)
		end
		it 'should choose the word "test"' do
			
			words = ["test"]
			word = h.choose_word(words)
			expect(word).to eq "test"
		end

		it "should strip newline character from the word" do
			words = ["test\n"]
			word = h.choose_word(words)
			expect(word.include? "\n").to eq false
		end

		it "should choose one of the words from the array" do
			words = %w(one two three four)
			word = h.choose_word(words)
			expect(words.include? word).to eq true
		end
	end
end

describe ConsoleIO do

end