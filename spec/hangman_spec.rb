require 'hangman'

describe Hangman do
  TEST_WORD = 'test'
  NUM_LIVES = 10
  let(:hangman) { Hangman.new(TEST_WORD, lives) }
  let(:lives) { NUM_aLIVES }

  describe '#validate_guess' do
    subject(:val_guess) { hangman.validate_guess(guess) }

    context 'when multiple characters entered' do
      let(:guess) { 'aa' }
      let(:error) { 'Please only input one letter, try again' }

      it 'returns correct error message' do
        expect(val_guess).to eq error
      end
    end

    context 'when a guess that has already been made is entered' do
      let(:guess) { hangman.word[0] }
      let(:error) { 'Already guessed, try again' }

      it 'returns correct error message' do
        hangman.add_to_guessed guess
        expect(val_guess).to eq error
      end
    end

    context 'when a non-alphabetic guess is made' do
      let(:guess) { '1' }
      let(:error) { 'Please only input letters, try again' }

      it 'displays correct error message' do
        expect(val_guess).to eq error
      end

      let(:guess) { '.' }

      it 'displays correct error message' do
        expect(val_guess).to eq error
      end

      let(:guess) { ' ' }

      it 'displays correct error message' do
        expect(val_guess).to eq error
      end
    end

    context 'when valid guess is made' do
      let(:guess) { hangman.word[0] }
      let(:error) { false }

      it 'returns false' do
        expect(val_guess).to eq error
      end
    end
  end

  describe '#game_over?' do
    context 'when game is not lost' do
      before do
        allow(hangman).to receive(:lost?).and_return(false)
      end

      context 'when all letters from the word are guessed' do
        it 'returns true ' do
          hangman.guessed = %w[t e s]
          expect(hangman).to be_game_over
        end
      end

      context 'when not all letters from the word are guessed' do
        it 'returns false' do
          hangman.guessed = %w[t e]
          expect(hangman).not_to be_game_over
        end
      end

      context 'when no letters from the word are guessed' do
        it 'returns false' do
          hangman.guessed = []
          expect(hangman).not_to be_game_over
        end
      end

      context 'when some of the letters from word, and others that are not, are guessed' do
        it 'returns false' do
          hangman.guessed = %w[t e a q]
          expect(hangman).not_to be_game_over
        end
      end

      context 'when all letters from the word, along with other letters, are guessed'
      it 'returns true' do
        hangman.guessed = %w[t e s q m]
        expect(hangman).to be_game_over
      end
    end

    context 'when the game is not won' do
      before do
        allow(hangman).to receive(:won?).and_return(false)
      end

      context 'when there are 0 lives remaining' do
        it 'returns true' do
          hangman.guessed = %w[a b c d f g h i j k]
          expect(hangman).to be_game_over
        end
      end

      context 'when lives are greater than 0' do
        it 'returns false' do
          hangman.guessed = %w[a b c d]
          expect(hangman).not_to be_game_over
        end
      end
    end

    context 'when game is won' do
      before do
        allow(hangman).to receive(:won?).and_return(true)
      end

      context 'when game is not lost' do
        it 'returns true' do
          allow(hangman).to receive(:lost?).and_return(false)
          expect(hangman).to be_game_over
        end
      end

      context 'when game is lost' do
        it 'returns true' do
          allow(hangman).to receive(:lost?).and_return(true)
          expect(hangman).to be_game_over
        end
      end
    end

    context 'when game is lost' do
      before do
        allow(hangman).to receive(:lost?).and_return(true)
      end

      context 'when game is not won' do
        it 'returns true' do
          allow(hangman).to receive(:won?).and_return(false)
          expect(hangman).to be_game_over
        end
      end

      context 'when game is won' do
        it 'returns true' do
          allow(hangman).to receive(:won?).and_return(true)
          expect(hangman).to be_game_over
        end
      end
    end
  end

  describe '#masked_word' do
    before do
      hangman.guessed = guessed
    end

    context 'when no letters are guessed' do
      let(:guessed) { [] }
      it 'has nil elements up to word.size' do
        expect(hangman.masked_word).to eq [nil, nil, nil, nil]
      end
    end

    context 'when a letter from the word is guessed' do
      word_with_no_double_letters = 'word'
      let(:hangman) { Hangman.new(word_with_no_double_letters, lives) }
      let(:guessed) { [hangman.word[0]] }
      it 'has the letter in the index corresponding to that of the letter in the word, with nils elsewhere' do
        expect(hangman.masked_word).to eq [guessed[0], nil, nil, nil]
      end
    end

    context 'when all letters from the word are guessed' do
      let(:guessed) { hangman.word.uniq }
      it 'should have char elements at any point where the letter in the word is in guessed' do
        expect(hangman.masked_word).to eq hangman.word
      end
    end
  end

  describe '#lives_remaining' do
    before do
      hangman.guessed = guessed
    end

    context 'when elements in guessed are also in word' do
      let(:guessed) { [hangman.word[0], hangman.word[1]] }

      it 'equals initial lives' do
        expect(hangman.lives_remaining).to eq lives
      end
    end

    context 'when 2 elements from guessed are not in the word, and other elements are in the word' do
      let(:guessed) { [hangman.word[0], hangman.word[1], 'z', 'x'] }

      it 'equals lives minus 2' do
        expect(hangman.lives_remaining).to eq lives - 2
      end
    end

    context 'when 4 elements from guessed are not in the word, an no other elements' do
      new_word = 'zzzz'
      let(:hangman) { Hangman.new(new_word, lives) }
      let(:guessed) { %w[a b c d] }

      it 'equals lives minus 4' do
        expect(hangman.lives_remaining).to eq lives - 4
      end
    end
  end

  describe '.random_word' do
    let(:words) { %w[one two three] }

    context 'when a word is chosen from an array' do
      it 'is not nil' do
        expect(Hangman.random_word(words)).to be_truthy
      end

      it 'is from the array' do
        expect(words).to include Hangman.random_word(words)
      end
    end
  end
end
