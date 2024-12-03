# # Display time
# SPACESHIP_TIME_SHOW=true
#
# # Display username always
# SPACESHIP_USER_SHOW=always
#
# # Do not truncate path in repos
# SPACESHIP_DIR_TRUNC_REPO=false
#
# # Add custom Ember section
# # See: https://github.com/spaceship-prompt/spaceship-ember
# spaceship add ember
#
# # Add a custom vi-mode section to the prompt
# # See: https://github.com/spaceship-prompt/spaceship-vi-mode
# spaceship add --before char vi_mode

SPACESHIP_PROMPT_ORDER=(
  dir
  git
  line_sep
  exit_code
  user
  host
  char
)

SPACESHIP_RPROMPT_ORDER=(
  exec_time
  time
)

SPACESHIP_USER_SHOW=true
SPACESHIP_USER_PREFIX="["
SPACESHIP_USER_SUFFIX=""
SPACESHIP_USER_COLOR=yellow
SPACESHIP_USER_COLOR_ROOT=red

SPACESHIP_HOST_SHOW=true
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX="]"
SPACESHIP_HOST_COLOR=blue
SPACESHIP_HOST_COLOR_SSH=cyan

SPACESHIP_DIR_SHOW=true
SPACESHIP_DIR_PREFIX="in"
SPACESHIP_DIR_SUFFIX=" "
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_TRUNC_REPO=true
SPACESHIP_DIR_COLOR=cyan

SPACESHIP_EXEC_TIME_SHOW=true
SPACESHIP_EXEC_TIME_PREFIX=""
SPACESHIP_EXEC_TIME_SUFFIX="|"
SPACESHIP_EXEC_TIME_COLOR=yellow
SPACESHIP_EXEC_TIME_ELAPSED=0

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=""
SPACESHIP_TIME_SUFFIX=""
SPACESHIP_TIME_COLOR=yellow
SPACESHIP_TIME_FORMAT=%*
SPACESHIP_TIME_12HR=false

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "
