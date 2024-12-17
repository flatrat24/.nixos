{ pkgs, lib, config, inputs, ... }: {
  imports = [
    ./dashboard
    ./yazi
    ./telescope
    ./treesitter
    ./web-devicons
  ];
}
