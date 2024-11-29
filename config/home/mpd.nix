{ pkgs, ... }: {

  services.mpd = {
    enable = true;
    musicDirectory = /home/ea/Music;
    dbFile = "/home/ea/.mpd/database";
    playlistDirectory = /home/ea/.mpd/playlists;
    dataDir = /home/ea/.mpd;
    extraConfig = ''
      state_file        "~/.mpd/state"
      restore_paused  "yes"
      sticker_file      "~/.mpd/sticker.sql"
      auto_update       "yes"

      audio_output {  
          type          "pipewire"
          name          "PipeWire Sound Server"
          path          "/tmp/mpd.fifo"
          format        "44100:16:2"
      }

      audio_output {  
          type          "fifo"
          name          "my_fifo"
          path          "/tmp/mpd.fifo"
          format        "44100:16:2"
      }

      input {
        plugin          "curl"
      }
    '';
  };

  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "~/Music";
    settings = {
      media_library_primary_tag = "album_artist"              ;
      ncmpcpp_directory         = "~/.config/ncmpcpp"         ;
      startup_screen            = "media_library"             ;
      visualizer_data_source    = ''"/tmp/mpd.fifo"''         ;
      visualizer_output_name    = ''"PipeWire Sound Server"'' ;
      visualizer_in_stereo      = ''"yes"''                   ;
      visualizer_type           = ''"ellipse"''               ;
      visualizer_look           = ''"󰝤󰝤"''                    ;
      # TODO: visualizer not working
    };
    bindings = [
      { key = "y"        ; command = "dummy"                                                                                                                                   ; }
      { key = "m"        ; command = "dummy"                                                                                                                                   ; }
      { key = "ctrl-_"   ; command = "dummy"                                                                                                                                   ; }
      { key = "ctrl-v"   ; command = "dummy"                                                                                                                                   ; }
      { key = "s"        ; command = "dummy"                                                                                                                                   ; }
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
      { key = "p"        ; command = "play"                                                                                                                                    ; }
      { key = "backspace"; command = "stop"                                                                                                                                    ; }
      { key = "P"        ; command = "pause"                                                                                                                                   ; }
      { key = ">"        ; command = "next"                                                                                                                                    ; }
      { key = "<"        ; command = "previous"                                                                                                                                ; }
      { key = "."        ; command = "seek_forward"                                                                                                                            ; }
      { key = ","        ; command = "seek_backward"                                                                                                                           ; }
      { key = "="        ; command = "volume_up"                                                                                                                               ; }
      { key = "-"        ; command = "volume_down"                                                                                                                             ; }
      { key = "'"        ; command = "move_selected_items_down"                                                                                                                ; }
      { key = ";"        ; command = "move_selected_items_up"                                                                                                                ; }
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
      #### PLAYLISTS ####
      { key = "c"        ; command = "toggle_playing_song_centering"                                                                                                           ; }
      #### SEARCH ENGINE ####
      { key = "w"        ; command = "start_searching"                                                                                                                         ; }
      { key = "W"        ; command = "reset_search_engine"                                                                                                                     ; }
      #### TAG EDITOR ####
      { key = "w"        ; command = "save_tag_changes"                                                                                                                        ; }
    ];
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

  home.packages = with pkgs; [
    mpd
    mpc-cli
    ncmpcpp
    mpdscribble # config is currently .mpdscribble/mpdscribble.conf
    mpd-notification
  ];

}
