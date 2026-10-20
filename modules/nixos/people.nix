{ lib, ... }: {
  options.people.primaryUsername = lib.mkOption {
    type = lib.types.str;
    default = "ndane";
    description = "The primary user's username, shared across all NixOS/darwin/home-manager configs.";
  };

  options.people.hashedPassword = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = "$6$DwA4Gh5R6yoYOsSV$OKy2T3F/O7woBQcVVDAhkYR62pIhsLxC3Ko7FhbhYb5Yb4CQyYhgTe/7YMth8ScxIbYZ3Lc8lAB0a/AnMuxGT.";
    description = "The primary user's hashed password, shared across all NixOS/darwin/home-manager configs.";
  };
}
