require_relative '../lib/play_hangman'


describe PlayHangman do
  let(:play_hangman) {PlayHangman.new}
  let(:word) { "test"}

  describe 'create_word_array' do
    it 'should have 370101 elements' do
      expect(play_hangman.create_word_array.size).to eq 370101
    end
  end
  describe 'random_word' do
    it 'should choose the word "test"' do
      words = [word]
      chosen_word = play_hangman.random_word(words)
      expect(chosen_word).to eq "test"
    end

    it "should strip newline character from the word" do
      words = ["test\n"]
      chosen_word = play_hangman.random_word(words)
      expect(chosen_word.include? "\n").to eq false
    end

    it "should choose one of the words from the array" do
      words = %w(one two three four)
      chosen_word = play_hangman.random_word(words)
      expect(words.include? chosen_word).to eq true
    end
  end
end