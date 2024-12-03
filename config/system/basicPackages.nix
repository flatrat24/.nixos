{ pkgs, lib, config, ... }: {
  options = {
    basicPackages.enable = lib.mkEnableOption "enables basic packages";
  };

  config = lib.mkIf config.basicPackages.enable {
    environment.systemPackages = with pkgs; [
      wget
      git
      neovim
    ];
    
    programs.zsh.enable = true;
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
