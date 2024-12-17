{ pkgs, lib, config, inputs, ... }: {
  imports = [
    ./dashboard
    ./eyeliner
    ./indent-blankline
    ./leap
    ./rainbow-delimiters
    ./yazi
    ./telescope
    ./treesitter
    ./web-devicons
  ];
}
