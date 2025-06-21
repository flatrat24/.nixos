##=============================================##
##====== STARSHIP PROMPT ======================##
eval "$(starship init zsh)"
##=== Transient Prompt
# export TRANSIENT_PROMPT_PROMPT='$(/etc/profiles/per-user/ea/bin/starship prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
# export TRANSIENT_PROMPT_TRANSIENT_PROMPT='$(starship module character)'

##=============================================##
##====== EXTRA KEYBINDS =======================##
function set_keybinds() {
  bindkey '^k' up-line-or-history
  bindkey '^j' down-line-or-history
  bindkey '^f' autosuggest-accept
  bindkey '^[w' kill-region
}

add-zsh-hook precmd set_keybinds
