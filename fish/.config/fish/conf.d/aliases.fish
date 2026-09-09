if status is-interactive
	alias please="sudo"

	abbr -a ff "fastfetch"

	abbr -a l "ls -l"
	abbr -a la "ls -lA"
	abbr -a lsa "ls -A"

	abbr -a cls "clear"

    abbr -a run-whisper "whisper-server -m /home/tonbix/Documents/ai_models/ggml-large-v3-turbo.bin --port 8080 --convert -ml -1"
    abbr -a rwhisper "whisper-server -m /home/tonbix/Documents/ai_models/ggml-large-v3-turbo.bin --port 8080 --convert -ml -1"

    abbr -a wfr "wf-recorder -a -c av1_vaapi -g (~/.dotfiles/scripts/.config/scripts/screenshots/slurp.sh) -f ~/Videos/(date -Is).mp4"
end
