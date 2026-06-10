# Env vars
export NH_SHOW_ACTIVATION_LOGS := "1"

# Chores
default:
  @just --list

clean:
  nh clean all --optimise

# Targets
[working-directory: "iso"]
iso:
  nh os build-image --image-variant iso .#iso

desktop:
  just switch desktop

macbook:
  nh darwin switch .#macbook

work:
  just switch work

# Shared helpers
switch target:
  nh os switch .#{{target}}
