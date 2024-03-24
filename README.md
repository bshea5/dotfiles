# Dotfiles

My configuration files for bash, vim, tmux and so forth.

# Setup Notes

The intention is to be able to run a setup script after cloning the repo on a
Mac or Ubuntu (WSL) system and be up and running very quickly.

## Ubuntu

```bash
DOTFILES_DIR=$HOME/Repos/github.com/bshea5
mkdir -p $DOTFILES_DIR
cd $DOTFILES_DIR
git clone https://github.com/bshea5/dotfiles.git
cd dotfiles
```

## Windows and WSL setup

- Install WSL in powershell
  https://learn.microsoft.com/en-us/windows/wsl/install
- Install Windows Terminal `winget install --id Microsoft.WindowsTerminal -e`
- Get gruvbox-material color scheme for Windows Terminal.
- Open the settings.json in windows preview by opening a new tab and click on
  Settings while holding shift
- Paste in the colorschemes and asssign it to the Ubuntu profile in Windows
  Terminal

## Run

```
./setup
```

without sudo. Enter password as needed. Running with sudo doesn't recognize
brew.

# TODO

- Configure Python tooling
  - pip
  - pipenv
  - pyenv
  - poetry?
