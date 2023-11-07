#!/bin/bash
CURRENT_DIR="$(pwd)"
if [[ -d "~/.config/alacritty/alacritty-theme" ]]; then
  echo ""
else   
  git clone -n --depth=1 --filter=tree:0 \
    https://github.com/alacritty/alacritty-theme ~/.config/alacritty/alacritty-theme
  cd ~/.config/alacritty/alacritty-theme
  git sparse-checkout set --no-cone themes
  git checkout
fi
## Colors
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
DEFAULT_FG="$(printf '\033[39m')"  DEFAULT_BG="$(printf '\033[49m')"

## Directories
ALACRITTY_DIR="$HOME/.config/alacritty/"
THEMES_DIR="$HOME/.config/alacritty/alacritty-theme/themes"
check_files () {
    if [[ "$1" = themes ]]; then
        themes=($(ls $THEMES_DIR))
        echo ${#themes[@]}
    fi
    return
}
total_themes=$(check_files themes)
echo $total_themes
apply_themes() {
  local count=1
  THEMES=($(ls $THEMES_DIR))
  for i in "${THEMES[@]}"; do
    Themes_name=$(echo $i)
    echo ${ORANGE}"    [$count] ${Themes_name%.*}"
    count=$(($count+1))
  done
  { echo; read -p ${CYAN}"    [${RED}Select Themes (1 to $total_themes)${CYAN}]: ${GREEN}" answer; echo; }
  if [[ (-n "$answer") && ("$answer" -le $total_themes) ]]; then
    scheme=${THEMES[(( answer - 1 ))]}
    echo "    ${BLUE}[${RED}*${BLUE}] ${ORANGE}Applying Theme..."
    cat $THEMES_DIR/$scheme > $ALACRITTY_DIR/alacritty.yml
  else
    echo -n "    ${BLUE}[${RED}!${BLUE}] ${RED}Invalid Option, Try Again."
    { sleep 1; echo; apply_themes; }
  fi
    return
}
until [[ "$REPLY" =~ ^[q/Q]$ ]]; do
  clear
  echo "
  ${BLUE}[${RED}T${BLUE}] ${ORANGE}Themes
  ${BLUE}[${RED}F${BLUE}] ${CYAN}Fonts (Coming soon...)
  "
  { read -p ${BLUE}"    [${RED}Select Option${BLUE}]: ${GREEN}"; echo; }
  if [[ $REPLY =~ ^[t/T]$ ]]; then
    apply_themes
  elif [[ $REPLY =~ ^[q/Q]$ ]]; then 
    exit
  elif [[ $REPLY =~ ^[f/F]$ ]]; then 
    echo ${CYAN}Coming Soon...
  else
    echo $(RED)Invalid Option
  fi
done
