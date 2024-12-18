{ pkgs, lib, config, inputs, ... }: {
  imports = [
    ./comment
    ./dashboard
    ./eyeliner
    ./git
    ./indent-blankline
    ./leap
    ./lualine
    ./neoscroll
    ./nvim-surround
    ./rainbow-delimiters
    ./yazi
    ./telescope
    ./transparent
    ./treesitter
    ./web-devicons
  ];
}
