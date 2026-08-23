# setup_my_ubuntu

Bootstrap a fresh Ubuntu workstation with my preferred CLI tools, languages, and dotfiles. The script wires in package repositories, installs development tooling, and leaves the system ready for day-to-day work.

## What’s Included

- `curl` and `git`, installed first since later steps depend on them
- Core packages (`build-essential`, `gh`, `ripgrep`, `fzf`, `tmux`, `shfmt`, etc.)
- Utility tooling (`eza`, `bat`, `fd`, `diff-so-fancy` via the [PATH method](https://github.com/so-fancy/diff-so-fancy), `jq`, `tldr`, `zoxide`)
- Language/runtime setup (Node.js via `nvm`, Go 1.22.x, Rust toolchain, Python tooling, R with CRAN + r2u repos)
- Infrastructure CLIs (Terraform, Packer, AWS CLI, Homebrew + Oh My Posh)
- Editors and config (Neovim nightly tarball, Oh My Zsh, tmux config, chezmoi-applied dotfiles)

## Prerequisites

- Ubuntu 22.04+ with `sudo` access (script targets the `noble` codename in several repos).
- Reliable internet connection—the script downloads binaries and repo keys.
- Existing `~/.local/bin` directory or an alternative location on your `PATH` if you adjust the script (needed for zoxide/chezmoi install targets).
- Customise the Git identity at the top of the script if you are not Tay Jun Jie.

## Usage

Run the bootstrap remotely in one command:

```bash
curl -o- https://raw.githubusercontent.com/jj-tay/setup_my_ubuntu/main/setup_my_ubuntu.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/jj-tay/setup_my_ubuntu.git
cd setup_my_ubuntu
bash setup_my_ubuntu.sh
```

## Notes & Maintenance

- The script creates a temporary working directory and cleans it automatically when finished.
- Re-running is mostly idempotent: repo additions and package installs are safe, but language installers (NVM, Go tarball, Rustup) will overwrite existing toolchains.
- Keep an eye on hard-coded versions (e.g. Go `1.22.1`, NVM `v0.39.7`) and update them periodically.
- If you already have Homebrew or language toolchains installed, review the relevant sections before executing to avoid surprises.

When the script completes, open a new shell session so the environment (`brew shellenv`, Rust, nvm) is fully initialised.
