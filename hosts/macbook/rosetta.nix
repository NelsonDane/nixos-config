_: {
  # https://github.com/nix-darwin/nix-darwin/issues/786#issuecomment-1740868836
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license || true
  '';
}
