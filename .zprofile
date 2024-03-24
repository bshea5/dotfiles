# Only run on macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
  # needed for brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Only run these on Ubuntu

if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
  # needed for brew to work
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -r ~/.zshrc ]; then
  . ~/.zshrc
fi

export XDG_CONFIG_HOME="$HOME"/.config


# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
