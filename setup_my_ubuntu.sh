#!/bin/bash

setup_my_ubuntu() {

	# Switch to temp directory
	TEMP_DIR=$(mktemp -d -q)
	pushd $TEMP_DIR >/dev/null

	# Upgrade packages
	sudo apt-get update
	sudo apt-get dist-upgrade -y

	# Install build-essential
	sudo apt-get install -y build-essential

	# Config git
	git config --global user.name 'Tay Jun Jie'
	git config --global email.name 'jjat1987@gmail.com'

	# Install gh
	sudo apt-get install -y gh

	# Install diff-so-fancy
	sudo add-apt-repository -y ppa:aos1/diff-so-fancy
	sudo apt-get install -y diff-so-fancy

	# Install eza
	sudo apt-get install -y gpg
	if [ ! -d "/etc/apt/keyrings" ]; then sudo mkdir -p /etc/apt/keyrings; fi
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --batch --yes -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt-get update
	sudo apt-get install -y eza

	# Install bat
	sudo apt-get install -y bat

	# Install fd
	sudo apt-get install -y fd-find

	# Install rigrep
	sudo apt-get install -y ripgrep

	# Install fzf
	sudo apt-get install -y fzf

	# Install zsh
	sudo apt-get install -y zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	# Install tmux
	sudo apt-get install -y tmux
	git clone https://github.com/gpakosz/.tmux.git ~
	ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf

	# Install python3-pip
	sudo apt-get install -y python3-pip
	sudo apt-get install -y python3-venv

	# Install R
	sudo apt-get install -y --no-install-recommends software-properties-common dirmngr
	wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
	sudo add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
	sudo apt-get install -y --no-install-recommends r-base
  sudo apt-get install -y --no-install-recommends wget ca-certificates gnupg
  wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc \
    | sudo tee -a /etc/apt/trusted.gpg.d/cranapt_key.asc
  echo "deb [arch=amd64] https://r2u.stat.illinois.edu/ubuntu noble main" \
    | sudo tee /etc/apt/sources.list.d/cranapt.list
  cat << EOF | sudo tee /etc/apt/preferences.d/99cranapt
Package: *
Pin: release o=CRAN-Apt Project
Pin: release l=CRAN-Apt Packages
Pin-Priority: 700
EOF
  sudo apt-get install -y --no-install-recommends python3-{dbus,gi,apt}
  sudo Rscript --vanilla -e 'install.packages("bspm", repos="https://cran.r-project.org")'
  RHOME=$(R RHOME)
  cat << EOF | sudo tee -a ${RHOME}/etc/Rprofile.site
suppressMessages(bspm::enable())
options(bspm.version.check=FALSE)
EOF
	sudo apt-get install -y r-cran-tidyverse

	# Install NodeJS
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
	nvm install 20

	# Install go
	curl -LO https://go.dev/dl/go1.22.1.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
 
 	# Install Rust
  	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

	# Install terraform and packer
	wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	sudo apt-get -y update
	sudo apt-get install -y terraform packer

	# Install neovim
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim*
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
	rm nvim-linux64.tar.gz
 	sudo apt-get install -y tree-sitter-cli fonts-powerline

	# Install awscli
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	sudo apt-get install -y unzip
	unzip -q awscliv2.zip
	sudo ./aws/install

	# Install tldr
	npm install -g tldr

	# Install zoxide
	curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

	# Install lazygit
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin

	# Install jq
	sudo apt-get install -y jq

 	# Install shfmt
	sudo apt-get install -y shfmt

  # Install Homebrew for Oh My Posh
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install Oh My Posh
  brew install jandedobbeleer/oh-my-posh/oh-my-posh

 	# Install chezmoi and apply dotfiles
	sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply jj-tay

	# Cd back to original directory
	popd
	rm -Rf $TEMP_DIR

}

setup_my_ubuntu
