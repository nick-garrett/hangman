require_relative '../lib/hangman'

describe Hangman do
  let(:hangman) { Hangman.new('test') }
  let(:word) { 'test' }
  before(:each) do
    hangman.word = word
  end

  describe 'check_guess' do
    it 'should not accept multiple characters' do
      expect(hangman.check_guess('aa')).not_to eq nil
    end

    it 'should not accept guesses already made' do
      hangman.guessed.push 'a'
      expect(hangman.check_guess('a')).not_to eq nil
    end

    it 'should not accept non-alphabetic guesses' do
      expect(hangman.check_guess('1')).not_to eq nil
      expect(hangman.check_guess('!')).not_to eq nil
      expect(hangman.check_guess(' ')).not_to eq nil
    end

    it 'should accept other guesses' do
      expect(hangman.check_guess('a')).to eq nil
      expect(hangman.check_guess('b')).to eq nil
      expect(hangman.check_guess('c')).to eq nil
    end
  end

  describe 'win?' do
    it 'should return true when all of the letters in \
    the word are also in the guessed array' do
      hangman.guessed = %w[t e s]
      expect(hangman.win?).to eq true
    end

    it 'should return false when some of the letters \
    in the word are in the guessed array' do
      hangman.guessed = %w[t e]
      expect(hangman.win?).to eq false
    end

    it 'should return false when no letters in the \
    word are in the guessed array' do
      hangman.guessed = []
      expect(hangman.win?).to eq false
    end

    it 'should return false when combination of some \
    letters in the word and other letters are in the guessed array' do
      hangman.guessed = %w[t e a q]
      expect(hangman.win?).to eq false
    end

    it 'should return true when all letters from the \
    word and some others are in the guessed array' do
      hangman.guessed = %w[t e s q m]
      expect(hangman.win?).to eq true
    end
  end

  describe 'lose?' do
    it 'should return true when there are 0 lives' do
      hangman.guessed = %w[a b c d f g h i j k]
      expect(hangman.lose?).to eq true
    end

    it 'should return false when lives are greater than 0' do
      hangman.guessed = %w[a b c d]
      expect(hangman.lose?).to eq false
    end
  end

  describe 'guess_state' do
    it 'should have nil elements at any point where the letter \
    in the word is not in guessed' do
      hangman.guessed = []
      expect(hangman.guess_state).to eq [nil, nil, nil, nil]

      hangman.guessed = ['e']
      expect(hangman.guess_state).to eq [nil, 'e', nil, nil]
    end

    it 'should have char elements at any point where the \
    etter in the word is in guessed' do
      hangman.guessed = %w[t s e]
      expect(hangman.guess_state).to eq %w[t e s t]
    end
  end

  describe 'lives_remaining' do
    it 'should equal total lives minus number of guesses not in the word' do
      hangman.guessed = %w[t s e]
      expect(hangman.lives_remaining).to eq 10

      hangman.guessed = %w[t s q w]
      expect(hangman.lives_remaining).to eq 8

      hangman.guessed = []
      expect(hangman.lives_remaining).to eq 10

      hangman.guessed = %w[a b c d f]
      expect(hangman.lives_remaining).to eq 5
    end
  end
end
