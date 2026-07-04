{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.discord.gameDetect = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Vesktop can't recognize games, so instead we use Discord with vencord on desktops.";
  };

  config.environment.systemPackages = with pkgs; [
    (if config.discord.gameDetect then discord.override { withVencord = true; } else vesktop)
  ];
}
