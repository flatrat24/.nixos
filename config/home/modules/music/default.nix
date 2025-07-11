{ pkgs, lib, config, ... }:
let
  cfg = config.music;
  aliases = {
    "n" = "ncmpcpp";
  };
  importMusic = pkgs.writeShellApplication {
    name = "importMusic";
    runtimeInputs = with pkgs; [
      yt-dlp
      beets
      gnused
    ];
    text = builtins.readFile ./sources/importMusic;
  };
  mpdDependencies = with pkgs; [
    mpd
    mpc-cli
    mpdscribble
    mpd-notification
  ];
  ncmpcppDependencies = with pkgs; [
    ncmpcpp
  ];
  importMusicDependencies = [
    importMusic
    pkgs.beets
    pkgs.yt-dlp
  ];
  cavaDependencies = with pkgs; [
    cava
  ];
in {
  options = {
    music = {
      enable = lib.mkEnableOption "enables music";
      mpd = {
        enable = lib.mkOption {
          description = "enables mpd";
          type = lib.types.bool;
          default = cfg.enable;
        };
        ncmpcpp.enable = lib.mkOption {
            description = "enables ncmpcpp";
            type = lib.types.bool;
            default = cfg.mpd.enable;
        };
      };
      importMusic.enable = lib.mkOption {
          description = "enables importMusic";
          type = lib.types.bool;
          default = cfg.enable;
      };
      cava.enable = lib.mkOption {
          description = "enables cava";
          type = lib.types.bool;
          default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf cfg.mpd.enable {
      home.packages = mpdDependencies;

      services.mpd = {
        enable = true;
        musicDirectory = "${config.home.homeDirectory}/Music"; # TODO: Use user directory dynamically
        dbFile = "${config.home.homeDirectory}/.mpd/database";
        playlistDirectory = "${config.home.homeDirectory}/.mpd/playlists"; # TODO: Use user directory dynamically
        dataDir = "${config.home.homeDirectory}/.config/mpd"; # TODO: Use user directory dynamically
        extraConfig = ''
          state_file     "~/.mpd/state"
          restore_paused "yes"
          sticker_file   "~/.mpd/sticker.sql"
          auto_update    "yes"

          audio_output {  
            type   "fifo"
            name   "Visualizer"
            path   "/tmp/mpd.fifo"
            format "44100:16:2"
          }

          audio_output {
            type "pipewire"
            name "PipeWire Sound Server"
          }

          input {
            plugin          "curl"
          }
        '';
      };
      home.file = {
        ".mpdscribble/mpdscribble.conf" = {
          text = ''
            verbose = 1
            host = localhost
            port = 6600

            [last.fm]
            url = https://post.audioscrobbler.com/
            username = being_pool
            password = 22dcd898e12ef1a9aa614284e6d82ecc
            journal = /var/cache/mpdscribble/lastfm.journal
          '';
          executable = false;
          recursive = false;
        };
      };
      home.file = {
        ".config/mpd-notification.conf" = {
          text = ''
          host = localhost
          port = 6600
          scale = 200
          text-topic = MPD Notification
          text-play = Playing <b>%t</b>\nby <i>%a</i>\nfrom <i>%A</i>
          text-pause = Paused <b>%t</b>\nby <i>%a</i>\nfrom <i>%A</i>
          text-stop = Stopped playback
          timeout = 5
          music-dir = /home/ea/Music/
          '';
          executable = false;
          recursive = false;
        };
      };
    })
    
    (lib.mkIf cfg.mpd.ncmpcpp.enable {
      programs.bash.shellAliases = aliases;
      programs.zsh.shellAliases = aliases;

      home.packages = ncmpcppDependencies;

      programs.ncmpcpp = {
        enable = true;
        mpdMusicDir = "~/Music";
        settings = {
          ##--- Technical ---##
          media_library_primary_tag = "album_artist";
          ncmpcpp_directory         = "~/.config/ncmpcpp";
          startup_screen            = "media_library";

          ##--- Miscellaneous ---##
          external_editor = "nvim";
          autocenter_mode = "yes";
          centered_cursor = "yes";

          ##--- Visualizer ---##
          visualizer_data_source          = "/tmp/mpd.fifo";
          visualizer_output_name          = "Visualizer";
          # visualizer_type                 = "spectrum";
          visualizer_spectrum_smooth_look = "yes";
          visualizer_look                 = "󰝤󰝤"; # TODO: Fix visualizer
          visualizer_fps                  = "60";

          ##--- Basic UI ---##
          user_interface       = "classic";
          colors_enabled       = "yes";
          color1               = "green"; # Selected item color
          color2               = "black"; # I don't know
          main_window_color    = "blue"; # Self explanatory
          current_item_prefix  = "$(green)$r"; # Highlight when hovering over an item
          current_item_suffix  = "$/r$(white)"; # Unselected items

          ##--- Popup Menu ---##
          window_border_color  = "green";
          active_window_border = "red";

          ##--- Current Playlist Layout ---##
          song_columns_list_format = "(6)[red]{n} (39)[yellow]{t}|{f} (35)[green]{b}|{D} (15)[blue]{A} (5)[magenta]{l}";

          ##--- Progress Bar ---##
          progressbar_look = "━█─";
          progressbar_color = "black";
          progressbar_elapsed_color = "default"; #this basically sets it to the foreground color

          ##--- Now Playing Song ---###
          song_status_format = "{$4%t [$3%b$9] - $5%A}|{$4%f}";
        };
        bindings = [
          # { key = "m"        ; command = "dummy"                                                                                                                                   ; }
          { key = "ctrl-_"   ; command = "dummy"                                                                                                                                   ; }
          { key = "ctrl-v"   ; command = "dummy"                                                                                                                                   ; }
          { key = "y"        ; command = "dummy"                                                                                                                                   ; }
          { key = "U"        ; command = "dummy"                                                                                                                                   ; }
          { key = "up"       ; command = "dummy"                                                                                                                                   ; }
          { key = "down"     ; command = "dummy"                                                                                                                                   ; }
          { key = "page_up"  ; command = "dummy"                                                                                                                                   ; }
          { key = "page_down"; command = "dummy"                                                                                                                                   ; }
          { key = "home"     ; command = "dummy"                                                                                                                                   ; }
          { key = "end"      ; command = "dummy"                                                                                                                                   ; }
          { key = "shift-tab"; command = "dummy"                                                                                                                                   ; }
          { key = "right"    ; command = "dummy"                                                                                                                                   ; }
          { key = "left"     ; command = "dummy"                                                                                                                                   ; }
          { key = "+"        ; command = "dummy"                                                                                                                                   ; }
          { key = "f"        ; command = "dummy"                                                                                                                                   ; }
          { key = "b"        ; command = "dummy"                                                                                                                                   ; }
          { key = "T"        ; command = "dummy"                                                                                                                                   ; }
          #### MOVEMENT ####
          { key = "j"        ; command = "scroll_down"                                                                                                                             ; }
          { key = "k"        ; command = "scroll_up"                                                                                                                               ; }
          { key = "K"        ; command = [ "scroll_up" "scroll_up" "scroll_up" "scroll_up" "scroll_up" ]                                                                           ; }
          { key = "J"        ; command = [ "scroll_down" "scroll_down" "scroll_down" "scroll_down" "scroll_down" ]                                                                 ; }
          { key = "ctrl-k"   ; command = "page_up"                                                                                                                                 ; }
          { key = "ctrl-j"   ; command = "page_down"                                                                                                                               ; }
          { key = "["        ; command = "scroll_up_album"                                                                                                                         ; }
          { key = "]"        ; command = "scroll_down_album"                                                                                                                       ; }
          { key = "{"        ; command = "scroll_up_artist"                                                                                                                        ; }
          { key = "}"        ; command = "scroll_down_artist"                                                                                                                      ; }
          { key = "g"        ; command = "move_home"                                                                                                                               ; }
          { key = "G"        ; command = "move_end"                                                                                                                                ; }
          { key = "l"        ; command = "next_column"                                                                                                                             ; }
          { key = "l"        ; command = "slave_screen"                                                                                                                            ; }
          { key = "h"        ; command = "jump_to_parent_directory"                                                                                                                ; }
          { key = "h"        ; command = "previous_column"                                                                                                                         ; }
          { key = "h"        ; command = "master_screen"                                                                                                                           ; }
          { key = "1"        ; command = "show_playlist"                                                                                                                           ; }
          { key = "2"        ; command = "show_browser"                                                                                                                            ; }
          { key = "3"        ; command = "show_search_engine"                                                                                                                      ; }
          { key = "3"        ; command = "reset_search_engine"                                                                                                                     ; }
          { key = "4"        ; command = "show_media_library"                                                                                                                      ; }
          { key = "4"        ; command = "toggle_media_library_columns_mode"                                                                                                       ; }
          { key = "5"        ; command = "show_playlist_editor"                                                                                                                    ; }
          { key = "6"        ; command = "show_tag_editor"                                                                                                                         ; }
          { key = "7"        ; command = "show_outputs"                                                                                                                            ; }
          { key = "8"        ; command = "show_visualizer"                                                                                                                         ; }
          { key = "9"        ; command = "show_clock"                                                                                                                              ; }
          { key = "@"        ; command = "show_server_info"                                                                                                                        ; }
          #### GLOBAL ####
          { key = "backspace"; command = "stop"                                                                                                                                    ; }
          { key = "P"        ; command = "pause"                                                                                                                                   ; }
          { key = ">"        ; command = "next"                                                                                                                                    ; }
          { key = "<"        ; command = "previous"                                                                                                                                ; }
          { key = "."        ; command = "seek_forward"                                                                                                                            ; }
          { key = ","        ; command = "seek_backward"                                                                                                                           ; }
          { key = "="        ; command = "volume_up"                                                                                                                               ; }
          { key = "-"        ; command = "volume_down"                                                                                                                             ; }
          { key = "'"        ; command = "move_selected_items_down"                                                                                                                ; }
          { key = ";"        ; command = "move_selected_items_up"                                                                                                                  ; }
          { key = "\\\""     ; command = [ "move_selected_items_down" "move_selected_items_down" "move_selected_items_down" "move_selected_items_down" "move_selected_items_down" ]; }
          { key = ":"        ; command = [ "move_selected_items_up" "move_selected_items_up" "move_selected_items_up" "move_selected_items_up" "move_selected_items_up" ]          ; }
          { key = "n"        ; command = "next_found_item"                                                                                                                         ; }
          { key = "N"        ; command = "previous_found_item"                                                                                                                     ; }
          #### MISCELLANEOUS ####
          { key = "space"    ; command = [ "select_item" "scroll_down" ]                                                                                                           ; }
          { key = "enter"    ; command = "enter_directory"                                                                                                                         ; }
          { key = "enter"    ; command = "toggle_output"                                                                                                                           ; }
          { key = "enter"    ; command = "run_action"                                                                                                                              ; }
          { key = "enter"    ; command = "play_item"                                                                                                                               ; }
          { key = "tab"      ; command = "add_item_to_playlist"                                                                                                                    ; }
          { key = "tab"      ; command = "toggle_lyrics_update_on_song_change"                                                                                                     ; }
          { key = "tab"      ; command = "toggle_visualization_type"                                                                                                               ; }
          { key = "x"        ; command = "delete_playlist_items"                                                                                                                   ; }
          { key = "x"        ; command = "delete_browser_items"                                                                                                                    ; }
          { key = "x"        ; command = "delete_stored_playlist"                                                                                                                  ; }
          { key = ":"        ; command = "execute_command"                                                                                                                         ; }
          { key = "u"        ; command = "update_database"                                                                                                                         ; }
          { key = "?"        ; command = "show_help"                                                                                                                               ; }
          { key = "s"        ; command = "toggle_single"                                                                                                                           ; }
          #### PLAYLISTS ####
          { key = "c"        ; command = "toggle_playing_song_centering"                                                                                                           ; }
          #### SEARCH ENGINE ####
          { key = "w"        ; command = "start_searching"                                                                                                                         ; }
          { key = "W"        ; command = "reset_search_engine"                                                                                                                     ; }
          #### TAG EDITOR ####
          { key = "w"        ; command = "save_tag_changes"                                                                                                                        ; }
        ];
      };
    })
    
    (lib.mkIf cfg.importMusic.enable {
      home.packages = importMusicDependencies;

      home.file = {
        ".config/yt-dlp/albumconfig.conf" = {
          source = ./sources/yt-dlp/albumconfig.conf;
          executable = false;
          recursive = false;
        };
      };

      home.file = {
        ".config/beets/config.yaml" = {
          source = ./sources/beets/config.yaml;
          executable = false;
          recursive = false;
        };
      };
    })

    (lib.mkIf cfg.cava.enable {
      home.packages = cavaDependencies;

      home.file = {
        ".config/cava/config" = {
          text = ''
            [color]
            gradient = 1

            gradient_color_8 = '#94e2d5'
            gradient_color_7 = '#89dceb'
            gradient_color_6 = '#74c7ec'
            gradient_color_5 = '#89b4fa'
            gradient_color_4 = '#cba6f7'
            gradient_color_3 = '#f5c2e7'
            gradient_color_2 = '#eba0ac'
            gradient_color_1 = '#f38ba8'
          '';
          executable = false;
        };
      };
    })
  ]);
}
