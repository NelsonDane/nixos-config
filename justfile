# Chores
default:
  @just --list

gc:
  sudo nix-collect-garbage --delete-old
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Targets
desktop:
  just switch desktop

macbook:
  sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .#macbook

work:
  just switch work

# Shared helpers
switch target:
  sudo nixos-rebuild switch --upgrade --flake .#{{target}}
