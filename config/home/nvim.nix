{ pkgs, ... }: {

  home.file = {
    ".config/nvim" = {
      source = ./sources/nvim;
      executable = false;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    neovim
    python3
    luajitPackages.luarocks
    luajitPackages.jsregexp
    clang
    tree-sitter
    nodejs_22
    python312Packages.python-lsp-server
    nodePackages_latest.bash-language-server
  ];

  # xdg.desktopEntries = {
  #   nvim = {
  #     name = "Neovim";
  #     genericName = "Text Editor";
  #     exec = ''foot -e "nvim %F" %f'';
  #     terminal = false;
  #     categories = [ "Utility" "TextEditor" ];
  #     mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++" "text/x-python" ];
  #   };
  # };

}
