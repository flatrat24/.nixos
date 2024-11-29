{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    git
    neovim
  ];
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
