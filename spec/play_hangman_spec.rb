require_relative '../lib/play_hangman'

describe 'random_word' do
  it 'should choose the word "test"' do
    words = ['test']
    chosen_word = PlayHangman.new.random_word(words)
    expect(chosen_word).to eq 'test'
  end

  it 'should strip newline character from the word' do
    words = ["test\n"]
    chosen_word = PlayHangman.new.random_word(words)
    expect(chosen_word.include?("\n")).to eq false
  end

  it 'should choose one of the words from the array' do
    words = %w[one two three four]
    chosen_word = PlayHangman.new.random_word(words)
    expect(words.include?(chosen_word)).to eq true
  end
end
