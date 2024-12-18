{ pkgs, lib, config, inputs, ... }: {
  imports = [
    ./comment
    ./dashboard
    ./eyeliner
    ./indent-blankline
    ./leap
    ./lualine
    ./nvim-surround
    ./rainbow-delimiters
    ./yazi
    ./telescope
    ./treesitter
    ./web-devicons
  ];
}
