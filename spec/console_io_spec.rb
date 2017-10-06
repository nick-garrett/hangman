require 'console_io'
describe ConsoleIO do
  let(:ui) { ConsoleIO.new }

  describe '#new_game?' do
    before do
      allow($stdin).to receive(:gets).and_return(user_response)
    end

    context 'when responding to "y"' do
      let(:user_response) { 'y' }

      it 'returns true' do
        expect(ui).to be_new_game
      end
    end

    context 'when responding to "Y"' do
      let(:user_response) { 'Y' }

      it 'returns true when "Y" as input' do
        expect(ui).to be_new_game
      end
    end

    context 'when responding to "n"' do
      let(:user_response) { 'n' }

      it 'returns false whe "n" as input' do
        expect(ui.new_game?).to eq false
      end
    end
  end

  describe '#status' do
    context 'when passed cur_guessed_word of all nils, num_lives of 10, and empty guessed_letters' do
      let(:cur_guessed_word) { [nil, nil, nil, nil] }
      let(:num_lives) { 10 }
      let(:guessed_letters) { [] }

      it 'puts "Current guess: ", then nothing, then puts an empty line, "Lives remaining: ", the number 10, "Letters guessed: ", then an empty line' do
        expect { ui.status(cur_guessed_word, num_lives, guessed_letters) }.to output("Current guess: \n____\nLives remaining: \n10\nLetters guessed: \n\n").to_stdout
      end
    end

    context 'when passed cur_guessed_word of all chars, num_lives of 10, and non-empty guessed_letters' do
      let(:cur_guessed_word) { %w[t e s t] }
      let(:num_lives) { 5 }
      let(:guessed_letters) { %w[a b c d] }

      it 'puts "Current guess: ", then prints each character in the array, puts "Lives remaining: ", the number 5, "Letters guessed: ", then each letter in the guessed_letters array with a space in between' do
        expect { ui.status(cur_guessed_word, num_lives, guessed_letters) }.to output("Current guess: \ntest\nLives remaining: \n5\nLetters guessed: \na b c d \n").to_stdout
      end
    end
  end

  describe '#guess_prompt' do
    before do
      input = user_response
      allow($stdin).to receive(:gets).and_return(input)
    end

    context 'when user enters a single letter' do
      let(:user_response) { 'a' }

      it 'returns "a"' do
        expect(ui.guess_prompt).to eq 'a'
      end
    end

    context 'when user enters a single letter with a newline character' do
      let(:user_response) { "a\n" }

      it 'returns "a"' do
        expect(ui.guess_prompt).to eq 'a'
      end
    end

    context 'when user enters multiple letters' do
      let(:user_response) { 'aaaaaa' }

      it 'returns multiple letters' do
        expect(ui.guess_prompt).to eq 'aaaaaa'
      end
    end

    context 'when user enters number' do
      let(:user_response) { '1' }

      it 'returns number' do
        expect(ui.guess_prompt).to eq '1'
      end
    end

    context 'when user enters a space' do
      let(:user_response) { ' ' }

      it 'returns a space' do
        expect(ui.guess_prompt).to eq ' '
      end
    end

    context 'when user enters newline character' do
      let(:user_response) { "\n" }

      it 'returns  blank string' do
        expect(ui.guess_prompt).to eq ''
      end
    end
  end

  describe '#end_message' do
    let(:word) { %w[t e s t] }
    let(:msg) { 'Message!' }

    context 'when the method is called' do
      it 'puts msg, then "The word was " word' do
        expect { ui.end_message(msg, word) }.to output("#{msg}\nThe word was #{word.join}\n").to_stdout
      end
    end
  end
end
