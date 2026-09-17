# Env vars
export NH_SHOW_ACTIVATION_LOGS := "1"

# Chores
default:
  @just --list

clean:
  nh clean all --optimise

# Targets
iso:
  nh os build-image --image-variant iso .#iso --hostname nixos

desktop:
  just switch desktop

nas:
  # just switch nas
  NIX_SSHOPTS="-i ~/.ssh/nas" nh os switch .#nas --target-host ndane@10.0.2.20 --build-host ndane@10.0.2.20

macbook:
  nh darwin switch .#macbook

work:
  # needed to pick up root cert outside repo
  nh os switch .#work -- --impure

rekey:
  nix shell nixpkgs#age-plugin-yubikey -c nix run .#agenix-rekey.aarch64-darwin.rekey -- -a

# Shared helpers
switch target:
  nh os switch .#{{target}}
