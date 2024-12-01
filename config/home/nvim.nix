{ pkgs, ... }:
let
  dependencies = with pkgs; [
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
in {

  imports = [ 
    ./git.nix
    ./yazi.nix
    # ./fonts.nix
  ];

  home.packages = dependencies;

  home.file = {
    ".config/nvim" = {
      source = ./sources/nvim;
      executable = false;
      recursive = true;
    };
  };

  xdg = {
    enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = {"text/*" = ["nvim.desktop"];};
    desktopEntries = {
      nvim = {
        name = "Neovim";
        genericName = "Text Editor";
        # exec = ''foot -e "nvim %F" %f'';
        exec = "nvim %F";
        terminal = true;
        categories = [ "Utility" "TextEditor" ];
        mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++" "text/x-python" ];
      };
    };
  };

}
