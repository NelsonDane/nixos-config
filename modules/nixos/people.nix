{ lib, ... }: {
  options.people.primaryUsername = lib.mkOption {
    type = lib.types.str;
    default = "ndane";
    description = "The primary user's username, shared across all NixOS/darwin/home-manager configs.";
  };
}
