##--- User chooses the domain of the account ---##
domains=()
while IFS= read -r entry; do
  domains+=("$(echo "$entry" | sed 's/\/$//')")
done < <(fd --no-hidden --base-directory "$HOME/.password-store" --type d --case-sensitive | rg -v --pcre2 '^([A-Z][A-Z][A-Z]/?)*$')

chosenDomain=$(printf "%s\n" "${domains[@]}" | wofi --define=lines=7 --prompt="password store" -d)
if [ -z "$chosenDomain" ]; then # Verify the user made a choice
  exit 1
fi


##--- User chooses the account from the domain ---##
while IFS= read -r entry; do
  accounts+=("${entry//\.gpg/}")
done < <(fd --no-hidden --base-directory "$HOME/.password-store/$chosenDomain")

if [ "${#accounts[@]}" == 1 ]; then # if only one account exists, the user doesn't need to choose
  chosenAccount="${accounts[0]}"
  chosenAccount="${chosenAccount//.gpg/}"
else # the user needs to choose
  chosenAccount=$(printf "%s\n" "${accounts[@]}" | wofi --define=lines=5 --prompt="$chosenDomain" -d | sed 's/\.gpg$//')
  if [ -z "$chosenAccount" ]; then # Verify the user made a choice
    exit 1
  fi
fi


##--- Make a temporary buffer ---##
buf=$(mktemp)
pass show "$chosenDomain/$chosenAccount" >> "$buf"


##--- Verify entry is of minimum length ---##
linesInEntry=$(wc --lines < "$buf")
if ((linesInEntry < 3)); then
  notify-send -urgency=critical "Error: $chosenDomain/$chosenAccount" "Must contain a password, username, and email"
  exit 1
fi


##--- Get each field from the buffer ---##
password=$(sed -n '1p' "$buf")
if [ -z "$password" ]; then
  notify-send -urgency=critical "Error: $chosenDomain/$chosenAccount" "Entry does not have a password listed"
  exit 1
fi

username=$(sed -n '2p' "$buf")
if echo "$username" | rg -q "^username: .+"; then
  username="${username//username: /}"
else
  notify-send -urgency=critical "Error: $chosenDomain/$chosenAccount" "Username must begin with 'username: '"
  exit 1
fi

email=$(sed -n '3p' "$buf")
if echo "$email" | rg -q "^email: .+"; then
  email="${email//email: /}"
else
  notify-send -urgency=critical "Error: $chosenDomain/$chosenAccount" "Email must begin with 'email: '"
  exit 1
fi

comments=$(sed -n '5,$p' "$buf" | sed 's/^\s*//')

##--- User chooses which field they would like to copy ---##
fields=("password" "username" "email")
if [ -n "$comments" ]; then
  fields+=("comments")
fi

chosenField=$(printf "%s\n" "${fields[@]}" | wofi --define=lines="$((${#fields[@]} + 2))" --prompt="$chosenAccount" -d)
if [ -z "$chosenField" ]; then # Verify the user made a choice
  exit 1
fi
echo -e "${!chosenField}"


##--- Make sure to shred temp buffer ---##
shred -u "$buf"
