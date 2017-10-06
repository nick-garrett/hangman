require 'play_hangman'

describe PlayHangman do
  let(:game) { PlayHangman.new }

  describe '#play' do
    context 'when a new game is started' do
      before do
        allow(game).to receive(:game_loop)
        allow(game).to receive(:end_message)
        allow(game).to receive(:new_game?).and_return(false)
      end

      after do
        game.play
      end

      it 'creates a new_game' do
        expect(game).to receive(:new_game)
      end
    end
  end
  #   context 'when play is called, and new_game? returns false' do
  #     after do
  #       game.play
  #     end

  #     it 'calls new_game, game_loop, and end_message once, calls new_game? then ends' do
  #       expect(game).to receive(:new_game)
  #       expect(game).to receive(:game_loop)
  #       expect(game).to receive(:end_message)
  #     end
  #   end

  #   context 'when play is called, and new_game? returns true once, then false' do
  #     after do
  #       game.play
  #     end

  #     it 'calls new_game, game_loop, and end_message twice then ends' do
  #       expect(game).to receive(:new_game).twice
  #       expect(game).to receive(:game_loop).twice
  #       expect(game).to receive(:end_message).twice
  #       expect(game).to receive(:new_game?).twice.and_return(true, false)
  #     end
  #   end
  # end

  # describe '#new_game' do
  #   context 'when new_game is called' do
  #     it 'should set @ui and @hangman to corresponding arguments' do
  #       ui = double
  #       hangman = double
  #       game.send(:new_game, ui, hangman)
  #       expect(game.ui).to be(ui)
  #       expect(game.hangman).to be(hangman)
  #     end
  #   end
  # end

  # describe '#game_loop' do

  # end
end
