echo "install neovim"
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt -y install neovim

sudo apt install -y python-dev python-pip python3-dev python3-pip
echo 'set -g default-terminal "screen-256color"' >> ~/.byobu/profile.tmux

sudo pip3 install neovim flake8
sudo pip install neovim flake8

mkdir -p $HOME/.config/nvim
cp ./nvim/init.vim $HOME/.config/nvim/
cp ./nvim/dein.toml $HOME/.config/nvim/
cp ./flake8 $HOME/.config/

echo "git setting"
git config --global user.email "koh.oct.un@gmail.com"
git config --global user.name "k-nish"
git config --global core.editor 'nvim -c "set fenc=utf-8"'

echo "install peco"
tar -zxvf ./zsh/peco_linux_386.tar.gz
sudo cp peco_linux_386/peco /usr/local/bin/

echo "install necessary moduels"
sudo apt install -y ctags zsh curl tig git htop ack-grep parallel cmake byobu
sudo add-apt-repository ppa:lazygit-team/release && sudo apt-get update && sudo apt-get install lazygit

echo "install cargo"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "setup zsh"
echo "nishimura" | which zsh | xargs -t sudo -S chsh -s

echo "setup tmux"
cp ./tmux/.tmux.conf $HOME/.tmux.conf

echo "install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "setup zsh"
cp ./zsh/.zshrc $HOME/
echo "please install exa & ripgrep by cargo"
