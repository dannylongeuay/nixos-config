# NixOS Configuration

A modular, flake-based configuration for my personal and work machines. It manages three
classes of machine from a single repository:

| Machine     | Type       | System config           | Home config            |
| ----------- | ---------- | ----------------------- | ---------------------- |
| `desktop`   | NixOS      | `nixosConfigurations`   | `cyberdan@desktop`     |
| `laptop`    | NixOS      | `nixosConfigurations`   | `cyberdan@laptop`      |
| `workLaptop`| macOS      | `darwinConfigurations`  | `workUser`             |

The system level (NixOS / nix-darwin) and the user level (home-manager) are kept **separate**:
home-manager is a *standalone* deployment, not a NixOS module, so each is applied with its own
command. Everything is themed with **Catppuccin Mocha (mauve)** via the `catppuccin` module.
The desktop environment is **Hyprland** (Wayland).

## Repository structure

```
flake.nix                     # inputs + all machine outputs
flake.lock                    # pinned input revisions
modules/
├── nixos/                    # NixOS (system level)
│   ├── common/               # boot, nix, nh, networking, fonts, services, user, …
│   ├── gui/                  # hyprland, steam
│   ├── nvidia/               # graphics + drivers
│   ├── sound/                # pipewire
│   └── hosts/
│       ├── desktop/          # default.nix + hardware-configuration.nix
│       └── laptop/           # default.nix + hardware-configuration.nix
├── home-manager/             # home-manager (user level)
│   ├── common/               # cross-platform packages, programs, theme
│   ├── shell/                # fish (+tide), zsh, bat, fzf, zoxide, direnv
│   ├── tui/                  # helix (+ LSPs), yazi, bottom, k9s
│   ├── gui/                  # kitty, hyprland stack, zathura, theme, packages
│   ├── vc/                   # git, delta, gh
│   └── user/
│       ├── cyberdan/         # common.nix + desktop.nix + laptop.nix
│       └── daniel.longeuay/  # workLaptop.nix + aerospace.toml
└── nix-darwin/
    └── hosts/workLaptop.nix  # macOS system (homebrew casks, defaults)
```

**The import pattern.** A NixOS host (`modules/nixos/hosts/<host>/default.nix`) sets its
hostname and host-specific options, then imports its `hardware-configuration.nix` plus the
shared `common`/`gui`/`nvidia`/`sound` subtrees. A home profile
(`modules/home-manager/user/<user>/<host>.nix`) sets host-specific variables and shell
abbreviations, then imports a `common.nix` that pulls in the `common`/`gui`/`shell`/`tui`/`vc`
module trees. Adding a machine is mostly a matter of writing these two small files and wiring
them into `flake.nix`.

## Flakes vs. non-flakes

This repo is **fully flake-based**. `nix-command` and `flakes` are enabled in
`modules/nixos/common/nix.nix`, and every input is pinned in `flake.lock` for reproducible
builds. The flake exposes one output per machine, and `nixpkgs.follows` makes `home-manager`
and `nix-darwin` reuse the same `nixpkgs` so the closure isn't duplicated. Two notable inputs:
`catppuccin` (theme modules) and `claude-code` (an overlay providing an up-to-date
`claude-code` package).

The legacy *non-flake* approach (`nix-channel` + `/etc/nixos/configuration.nix` +
`<nixpkgs>` channels) is **not** used here. The flake replaces it: `--flake .#<name>` selects
an output instead of relying on ambient channels, which is why bootstrap below never runs
`nix-channel`.

> **Gotcha:** flake evaluation only sees files tracked by git. After creating new files (a new
> host, a copied `hardware-configuration.nix`, etc.) you **must** `git add -A` before
> rebuilding, or Nix won't find them.

## Bootstrap (fresh workstation)

### NixOS

Install NixOS (a minimal install is fine), then from the installed system:

```sh
nix-shell -p git
git clone https://github.com/dannylongeuay/nixos-config
cd nixos-config

# Reuse an existing host (desktop/laptop) or add a new one — see "Adding a workstation".
# Copy the machine's generated hardware config into the host directory:
sudo cp /etc/nixos/hardware-configuration.nix modules/nixos/hosts/<host>/

git add -A                                       # flakes ignore untracked files
sudo nixos-rebuild switch --flake .#<host>       # system level
nix run home-manager/master -- switch --flake .#cyberdan@<host>   # user level (standalone)

reboot
```

After the first `home-manager switch`, the `hms`/`nhs`/`nrs`/`nos` abbreviations (below) are
available for subsequent rebuilds.

### macOS (nix-darwin)

Install Nix (Determinate Systems installer or the official one), clone the repo, then:

```sh
nix run nix-darwin -- switch --flake .#workLaptop        # system level
nix run home-manager/master -- switch --flake .#workUser # user level (standalone)
```

Homebrew casks (`aerospace`, `doll`, `raycast`, `stats`) are declared in `workLaptop.nix` and
installed/updated automatically on activation.

## Adding a new workstation

### 1. NixOS host

- Create `modules/nixos/hosts/<host>/default.nix` modeled on `desktop/default.nix`: set
  `networking.hostName`, the `users.users.cyberdan` block, any host-specific options, and an
  `imports` list of `./hardware-configuration.nix` plus the shared subtrees you want
  (`../../common`, `../../gui`, `../../nvidia`, `../../sound`).
- Drop the machine's `hardware-configuration.nix` into that directory.
- Add a `nixosConfigurations.<host>` output to `flake.nix`, mirroring `desktop`.

### 2. Home profile

- Create `modules/home-manager/user/cyberdan/<host>.nix` modeled on `laptop.nix`: set the
  `hms`/`nhs`/`nrs`/`nos` fish abbreviations and any host variables (e.g.
  `hyprland_startup_apps`), then `imports = [ ./common.nix ];`.
- Add a `homeConfigurations."cyberdan@<host>"` output to `flake.nix`, mirroring the existing
  ones (include the `catppuccin.homeModules.catppuccin` module and the `pkgs.claude-code`
  package).

Then `git add -A` and rebuild both levels.

## Updating the flake

```sh
nix flake update              # update all inputs
nix flake update nixpkgs      # update a single input
```

Commit the resulting `flake.lock`, then re-apply the system and home configs (below) to build
against the new revisions. Old generations are garbage-collected automatically — `nix.gc` is
set to delete entries older than 30 days, on a per-host schedule (`nix.gc.dates`).

## Applying changes

System and user levels are applied separately. `nh` (the Nix Helper) is the preferred wrapper —
its `--ask` flag shows a diff/build preview before activating. Convenience abbreviations are
already defined per host.

| Level             | Preferred (`nh`)                                    | Raw command                                          | Abbrev      |
| ----------------- | --------------------------------------------------- | ---------------------------------------------------- | ----------- |
| System (NixOS)    | `nh os switch --ask --hostname <host> .`            | `sudo nixos-rebuild switch --flake .#<host>`         | `nos` / `nrs` |
| System (macOS)    | —                                                   | `sudo darwin-rebuild switch --flake .#workLaptop`    | `drs`       |
| Home-manager      | `nh home switch --ask --configuration cyberdan@<host> .` | `home-manager switch --flake .#cyberdan@<host>` | `nhs` / `hms` |

You generally run one system command **and** one home command after making changes, since the
two layers are independent.

## Packages & programs

Most tooling is modern, terminal-first replacements for traditional Unix utilities. Tables are
grouped by function; the **Replaces** column notes the conventional tool each one stands in for.

### Shell & prompt (terminal)

| Tool             | Replaces            | Purpose                                              |
| ---------------- | ------------------- | ---------------------------------------------------- |
| fish (+ tide)    | bash / interactive zsh | Interactive shell with the Tide prompt (`zsh` execs into it) |
| fzf (+ fzf.fish) | —                   | Fuzzy finder + shell key bindings                    |
| zoxide           | `cd`                | Frecency-based directory jumping (`z`, `zz`)         |
| direnv + nix-direnv | —                | Per-directory environments, with Nix shell caching   |
| nix-your-shell   | —                   | Keeps the fish shell inside `nix shell` / `nix develop` |

### File system & navigation (terminal)

| Tool        | Replaces     | Purpose                              |
| ----------- | ------------ | ------------------------------------ |
| eza         | `ls`         | Listing with icons/colors (`ls`, `ll`) |
| fd          | `find`       | Fast, ergonomic file finder          |
| yazi (`yy`) | ranger / lf  | TUI file manager                     |
| ncdu        | `du`         | Interactive disk-usage browser       |
| zoxide      | `cd`         | Smart directory navigation           |

### Search & text (terminal)

| Tool     | Replaces | Purpose                       |
| -------- | -------- | ----------------------------- |
| ripgrep  | `grep`   | Fast recursive search (`rg`)  |
| bat      | `cat`    | Syntax-highlighted pager      |
| jq       | —        | JSON query / transform        |

### Editor & development (terminal)

| Tool      | Replaces      | Purpose                                                        |
| --------- | ------------- | -------------------------------------------------------------- |
| helix     | vim / neovim  | Default editor; ships LSPs/formatters for nix, go, python, terraform, lua, bash, yaml/json, docker, markdown, ocaml, haskell, … |
| just      | make          | Command runner                                                 |
| watchexec | entr          | Run commands on file changes (`we`)                            |

### Version control (terminal)

| Tool  | Replaces            | Purpose                              |
| ----- | ------------------- | ------------------------------------ |
| git   | —                   | VCS, with conventional-commit helpers (`gfeat`, `gfix`, …) |
| delta | default diff pager  | Side-by-side, syntax-highlighted diffs |
| gh    | —                   | GitHub CLI (SSH protocol)            |

### Networking & HTTP (terminal)

| Tool          | Replaces | Purpose                                  |
| ------------- | -------- | ---------------------------------------- |
| httpie (`http`) | curl   | Human-friendly HTTP client               |
| `cht` helper  | —        | cheat.sh lookups via fzf                 |

### Cloud, Kubernetes & infra (terminal)

| Tool             | Replaces | Purpose                          |
| ---------------- | -------- | -------------------------------- |
| awscli2          | —        | AWS CLI (`aprof`, `awsso` helpers) |
| doctl            | —        | DigitalOcean CLI                 |
| kubectl (`k`)    | —        | Kubernetes CLI (`kprof` helper)  |
| k9s              | —        | Kubernetes TUI                   |
| terraform        | —        | Infrastructure as code (via helix extras) |
| aws-nuke, glab, sops | —    | macOS work profile only          |

### Monitoring & system info (terminal)

| Tool          | Replaces    | Purpose                       |
| ------------- | ----------- | ----------------------------- |
| bottom (`btm`)| top / htop  | Resource monitor              |
| fastfetch     | neofetch    | System info (fish greeting)   |

### AI (terminal)

| Tool        | Replaces | Purpose                       |
| ----------- | -------- | ----------------------------- |
| aichat      | —        | LLM chat in the terminal      |
| claude-code | —        | Anthropic's coding CLI (from the `claude-code` overlay) |

### Fun & misc (terminal)

| Tool                 | Replaces | Purpose                       |
| -------------------- | -------- | ----------------------------- |
| libqalculate (`qalc`)| bc       | Powerful calculator           |
| asciinema            | —        | Record terminal sessions      |
| asciiquarium, cbonsai| —        | Terminal eye-candy            |

### Desktop / GUI (graphical)

| Tool         | Replaces      | Purpose                              |
| ------------ | ------------- | ------------------------------------ |
| Hyprland     | —             | Wayland tiling compositor            |
| waybar       | —             | Status bar                           |
| tofi         | dmenu / rofi  | Application launcher                 |
| hyprlock     | —             | Screen locker                        |
| hyprpaper    | —             | Wallpaper daemon                     |
| hyprshot     | —             | Screenshots                          |
| mako         | dunst         | Notification daemon                  |
| wl-clipboard | xclip         | Wayland clipboard                    |
| kitty        | —             | GPU-accelerated terminal             |
| firefox      | —             | Web browser                          |
| zathura      | evince        | Keyboard-driven PDF viewer           |
| brightnessctl| —             | Backlight control                    |
| digital      | —             | Digital logic simulator              |

### System level (NixOS)

| Component            | Replaces      | Purpose                              |
| -------------------- | ------------- | ------------------------------------ |
| PipeWire             | PulseAudio    | Audio server                         |
| Steam                | —             | Gaming                               |
| Docker (rootless)    | —             | Containers (currently disabled)      |
| NVIDIA drivers       | —             | Proprietary graphics                 |
| Zen kernel           | stock kernel  | Desktop-tuned Linux kernel           |
| systemd-boot         | GRUB          | EFI bootloader                       |
| NetworkManager       | —             | Networking                           |
| Nerd Fonts           | —             | Patched fonts (JetBrains Mono, Hack, …) |

## Cheatsheet

| Abbrev | Expands to                                                |
| ------ | --------------------------------------------------------- |
| `nos`  | `nh os switch --ask --hostname <host> .`                  |
| `nrs`  | `sudo nixos-rebuild switch --flake .#<host>`              |
| `drs`  | `sudo darwin-rebuild switch --flake .#workLaptop` (macOS) |
| `nhs`  | `nh home switch --ask --configuration cyberdan@<host> .`  |
| `hms`  | `home-manager switch --flake .#cyberdan@<host>`           |
|        | `nix flake update` — refresh pinned inputs                |
