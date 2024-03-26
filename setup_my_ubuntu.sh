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
	if [ ! -d "~/bin" ]; then mkdir -p ~/bin; fi
	rm -Rf ~/bin/eza
	git clone https://github.com/eza-community/eza.git ~/bin

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
	cp ~/.tmux/.tmux.conf.local ~/.tmux.conf.local

	# Install python3-pip
	sudo apt-get install -y python3-pip
	sudo apt-get install -y python3-venv

	# Install R
	sudo apt-get install -y --no-install-recommends software-properties-common dirmngr
	wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
	sudo add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
	sudo apt-get install -y --no-install-recommends r-base
	sudo add-apt-repository -y ppa:c2d4u.team/c2d4u4.0+
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

	# Install awscli
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	sudo apt-get install -y unzip
	unzip -q awscliv2.zip
	sudo ./aws/install

	# Install tldr
	npm install -g tldr

	# Install chezmoi and apply dotfiles
	sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jj-tay

	# Cd back to original directory
	popd
	rm -Rf $TEMP_DIR

	# Change default shell
	chsh -s $(which zsh)
}

setup_my_ubuntu
