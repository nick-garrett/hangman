require 'play_hangman'

describe PlayHangman do
  let(:game) { PlayHangman.new }

  describe '#play' do
    after do
      game.play
    end

    context 'when a new game is started' do
      before do
        allow(game).to receive(:game_loop)
        allow(game).to receive(:end_message)
        allow(game).to receive(:new_game?).and_return(false)
      end

      it 'sets up the ui and hangman objects' do
        expect(game).to receive(:new_game!)
      end
    end

    context 'when ui and hangman objects have been created' do
      before do
        allow(game).to receive(:end_message)
        allow(game).to receive(:new_game?).and_return(false)
      end

      it 'runs the game loop' do
        expect(game).to receive(:game_loop)
      end
    end

    context 'when a game is finished' do
      before do
        allow(game).to receive(:game_loop)
        allow(game).to receive(:new_game?).and_return(false)
      end

      it 'sends an end game message' do
        expect(game).to receive(:end_message)
      end
    end

    context 'when the end game message has been sent' do
      before do
        allow(game).to receive(:game_loop)
        allow(game).to receive(:end_message)
      end

      it 'checks if a new game will be played' do
        expect(game).to receive(:new_game?).and_return(false)
      end
    end
  end

  describe '#game_loop' do
    let(:ui) { ConsoleIO.new }
    let(:hangman) { Hangman.new('word') }
    context 'when the game begins' do
      before do
        game.send(:new_game!, ui, hangman)
      end

      after do
        game.send(:game_loop)
      end

      it 'prints the status and asks for a guess until the game is over' do
        expect(hangman).to receive(:game_over?).and_return(false, false, true)
        expect(ui).to receive(:status).twice
        expect(game).to receive(:make_guess).twice
      end
    end
  end

  describe '#make_guess' do
    let(:ui) { ConsoleIO.new }
    let(:hangman) { Hangman.new('word') }
    let(:guess) { double }
    let(:error) { double }

    context 'when a user enters a valid guess' do
      before do
        game.send(:new_game!, ui, hangman)
      end

      after do
        game.send(:make_guess)
      end

      it 'prompts the user for a guess, validates the guess, and adds the guess to hangmans guessed array' do
        expect(ui).to receive(:guess_prompt).and_return(guess)
        expect(hangman).to receive(:validate_guess).with(guess).and_return(false)
        expect(hangman).to receive(:add_to_guessed).with(guess)
      end
    end

    context 'when a user enters an invalid guess' do
      before do
        game.send(:new_game!, ui, hangman)
      end

      after do
        game.send(:make_guess)
      end

      it 'prompts the user for a guess, validates the guess, and handles the error' do
        expect(ui).to receive(:guess_prompt).and_return(guess)
        expect(hangman).to receive(:validate_guess).with(guess).and_return(error)
        expect(game).to receive(:handle_guess_error).with(error)
      end
    end
  end

  describe '#handle_guess_error' do
    context 'when an invalid guess was made' do
      let(:error) { double }
      let(:ui) { ConsoleIO.new }
      let(:hangman) { Hangman.new('word') }

      before do
        game.send(:new_game!, ui, hangman)
      end

      after do
        game.send(:handle_guess_error, error)
      end

      it 'displays the error then gets another guess from the user' do
        expect(ui).to receive(:display_error).with(error)
        expect(game).to receive(:make_guess)
      end
    end
  end
end
