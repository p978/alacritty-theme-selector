#!/bin/bash
CURRENT_DIR="$(pwd)"
if [[ -d $CURRENT_DIR/"alacritty-theme" ]]; then
  echo ""
else   
  git clone -n --depth=1 --filter=tree:0 \
    https://github.com/alacritty/alacritty-theme
  cd alacritty-theme
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
KITTY_DIR="$HOME/.config/alacritty/"
THEMES_DIR="$CURRENT_DIR/"alacritty-theme/themes"" 
apply_themes() {
  count=1
  THEMES=($(ls $THEMES_DIR))
  for i in ${THEMES[@]}; do
    echo [$((count++))] $i
  done
  { read -p ${CYAN}"[${BLUE} Select Themes ${CYAN}]:"; echo; }
}
echo "
  ${BLUE}[${RED}T${BLUE}] ${ORANGE}Themes
  ${BLUE}[${RED}F${BLUE}] ${CYAN}Fonts (Coming soon...)
"

{ read -p ${BLUE}"    [${RED}Select Option${BLUE}]: ${GREEN}" ; echo; }
if [[ "$REPLY" =~ ^[t/T]$ ]]; then
  apply_themes
fi
##echo "    ${BLUE}[${RED}*${BLUE}] ${RED}Bye Bye, Have A Nice Day!";exit 0;
