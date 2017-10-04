#!/bin/bash
cd "${BASH_SOURCE%/*}"
bundle exec ruby -r "../lib/play_hangman.rb" -e "PlayHangman.new.play" 