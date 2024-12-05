{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    yazi
  ];
in {
  options = {
    yazi.enable = lib.mkEnableOption "enables yazi";
  };

  config = lib.mkIf config.yazi.enable {
    home.packages = dependencies;

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      keymap = {
        manager.keymap = [
          # General
          { on = [ "<Esc>" ];         run = "escape";                                             desc = "exit visual mode, clear selected, or cancel search"; }
          { on = [ "q" ];             run = "quit";                                               desc = "exit the process"; }
          { on = [ "q" ];             run = "quit --no-cwd-file";                                 desc = "exit the process without writing cwd-file"; }
          { on = [ "<C-q>" ];         run = "close";                                              desc = "close the current tab, or quit if it is last tab"; }
          { on = [ "<C-z>" ];         run = "suspend";                                            desc = "suspend the process"; }

          # navigation
          { on = [ "k" ];             run = "arrow -1";                                           desc = "move cursor up"; }
          { on = [ "j" ];             run = "arrow 1";                                            desc = "move cursor down"; }

          { on = [ "K" ];             run = "arrow -5";                                           desc = "move cursor up 5 lines"; }
          { on = [ "J" ];             run = "arrow 5";                                            desc = "move cursor down 5 lines"; }

          { on = [ "<C-k>" ];         run = "arrow -50%";                                         desc = "move cursor up half page"; }
          { on = [ "<C-j>" ];         run = "arrow 50%";                                          desc = "move cursor down half page"; }

          { on = [ "h" ];             run = "leave";                                              desc = "go back to the parent directory"; }
          { on = [ "l" ];             run = "enter";                                              desc = "enter the child directory"; }

          { on = [ "<" ];             run = "seek -5";                                            desc = "seek up 5 units in the preview"; }
          { on = [ ">" ];             run = "seek 5";                                             desc = "seek down 5 units in the preview"; }

          { on = [ "g" "g" ];         run = "arrow -99999999";                                    desc = "move cursor to the top"; }
          { on = [ "G" ];             run = "arrow 99999999";                                     desc = "move cursor to the bottom"; }

          # selection
          { on = [ "<Space>" ];       run = [ "select --state=none" "arrow 1" ];                  desc = "toggle the current selection state"; }
          { on = [ "v" ];             run = "visual_mode";                                        desc = "enter visual mode (selection mode)"; }
          { on = [ "v" ];             run = "visual_mode --unset";                                desc = "enter visual mode (unset mode)"; }
          { on = [ "<C-a>" ];         run = "select_all --state=true";                            desc = "select all files"; }
          { on = [ "<C-r>" ];         run = "select_all --state=none";                            desc = "inverse selection of all files"; }

          # operation
          { on = [ "<Enter>" ];       run = "open";                                               desc = "open the selected files"; }
          { on = [ "<C-Enter>" ];     run = "open --interactive";                                 desc = "open the selected files interactively"; }
          { on = [ "y" ];             run = "yank";                                               desc = "copy the selected files"; }
          { on = [ "y" ];             run = "unyank";                                             desc = "cancel the yank status of files"; }
          { on = [ "x" ];             run = "yank --cut";                                         desc = "cut the selected files"; }
          { on = [ "x" ];             run = "unyank";                                             desc = "cancel the yank status of files"; }
          { on = [ "p" ];             run = "paste";                                              desc = "paste the files"; }
          { on = [ "p" ];             run = "paste --force";                                      desc = "paste the files (overwrite if the destination exists)"; }
          { on = [ "-" ];             run = "link";                                               desc = "symlink the absolute path of files"; }
          { on = [ "_" ];             run = "link --relative";                                    desc = "symlink the relative path of files"; }
          { on = [ "d" ];             run = "remove";                                             desc = "move the files to the trash"; }
          { on = [ "d" ];             run = "remove --permanently";                               desc = "permanently delete the files"; }
          { on = [ "a" ];             run = "create";                                             desc = "create a file or directory (ends with / for directories)"; }
          { on = [ "r" ];             run = "rename --cursor=before_ext";                         desc = "rename a file or directory"; }
          { on = [ ";" ];             run = "shell --interactive";                                desc = "run a shell command"; }
          { on = [ ":" ];             run = "shell --interactive --block";                        desc = "run a shell command (block the ui until the command finishes)"; }
          { on = [ "." ];             run = "hidden toggle";                                      desc = "toggle the visibility of hidden files"; }
          { on = [ "s" ];             run = "search fd";                                          desc = "search files by name using fd"; }
          { on = [ "s" ];             run = "search rg";                                          desc = "search files by content using ripgrep"; }

          # linemode
          { on = [ "m" "s" ];         run = "linemode size";                                      desc = "set linemode to size"; }
          { on = [ "m" "p" ];         run = "linemode permissions";                               desc = "set linemode to permissions"; }
          { on = [ "m" "m" ];         run = "linemode mtime";                                     desc = "set linemode to mtime"; }
          { on = [ "m" "n" ];         run = "linemode none";                                      desc = "set linemode to none"; }
                              
          # copy                      
          { on = [ "c" "c" ];         run = "copy path";                                          desc = "copy the absolute path"; }
          { on = [ "c" "d" ];         run = "copy dirname";                                       desc = "copy the path of the parent directory"; }
          { on = [ "c" "f" ];         run = "copy filename";                                      desc = "copy the name of the file"; }
          { on = [ "c" "n" ];         run = "copy name_without_ext";                              desc = "copy the name of the file without the extension"; }
                              
          # filter                    
          { on = [ "f" ];             run = "filter --smart";                                     desc = "filter the files"; }

          # find
          { on = [ "/" ];             run = "find --smart";                                       desc = "find next file"; }
          { on = [ "?" ];             run = "find --previous --smart";                            desc = "find previous file"; }
          { on = [ "n" ];             run = "find_arrow";                                         desc = "go to next found file"; }
          { on = [ "n" ];             run = "find_arrow --previous";                              desc = "go to previous found file"; }

          # sorting
          { on = [ "," "m" ];         run = "sort modified --dir-first";                          desc = "sort by modified time"; }
          { on = [ "," "m" ];         run = "sort modified --reverse --dir-first";                desc = "sort by modified time (reverse)"; }
          { on = [ "," "c" ];         run = "sort created --dir-first";                           desc = "sort by created time"; }
          { on = [ "," "c" ];         run = "sort created --reverse --dir-first";                 desc = "sort by created time (reverse)"; }
          { on = [ "," "e" ];         run = "sort extension --dir-first";         	        desc = "sort by extension"; }
          { on = [ "," "e" ];         run = "sort extension --reverse --dir-first";               desc = "sort by extension (reverse)"; }
          { on = [ "," "a" ];         run = "sort alphabetical --dir-first";                      desc = "sort alphabetically"; }
          { on = [ "," "a" ];         run = "sort alphabetical --reverse --dir-first";            desc = "sort alphabetically (reverse)"; }
          { on = [ "," "n" ];         run = "sort natural --dir-first";                           desc = "sort naturally"; }
          { on = [ "," "n" ];         run = "sort natural --reverse --dir-first";                 desc = "sort naturally (reverse)"; }
          { on = [ "," "s" ];         run = "sort size --dir-first";                              desc = "sort by size"; }
          { on = [ "," "s" ];         run = "sort size --reverse --dir-first";                    desc = "sort by size (reverse)"; }

          # tabs
          { on = [ "t" ];             run = "tab_create --current";                               desc = "create a new tab using the current path"; }

          { on = [ "1" ];             run = "tab_switch 0";                                       desc = "switch to the first tab"; }
          { on = [ "2" ];             run = "tab_switch 1";                                       desc = "switch to the second tab"; }
          { on = [ "3" ];             run = "tab_switch 2";                                       desc = "switch to the third tab"; }
          { on = [ "4" ];             run = "tab_switch 3";                                       desc = "switch to the fourth tab"; }
          { on = [ "5" ];             run = "tab_switch 4";                                       desc = "switch to the fifth tab"; }
          { on = [ "6" ];             run = "tab_switch 5";                                       desc = "switch to the sixth tab"; }
          { on = [ "7" ];             run = "tab_switch 6";                                       desc = "switch to the seventh tab"; }
          { on = [ "8" ];             run = "tab_switch 7";                                       desc = "switch to the eighth tab"; }
          { on = [ "9" ];             run = "tab_switch 8";                                       desc = "switch to the ninth tab"; }

          { on = [ "[" ];             run = "tab_switch -1 --relative";                           desc = "switch to the previous tab"; }
          { on = [ "]" ];             run = "tab_switch 1 --relative";                            desc = "switch to the next tab"; }

          { on = [ "{" ];             run = "tab_swap -1";                                        desc = "swap the current tab with the previous tab"; }
          { on = [ "}" ];             run = "tab_swap 1";                                         desc = "swap the current tab with the next tab"; }

          # tasks
          { on = [ "w" ];             run = "tasks_show";                                         desc = "show the tasks manager"; }

          # goto
          { on = [ "g" "h" ];         run = "cd ~";                                               desc = "go to the home directory"; }
          { on = [ "g" "s" ];         run = "cd ~/documents/school";                              desc = "go to the school directory"; }
          { on = [ "g" "p" ];         run = "cd ~/documents/personal";                            desc = "go to the personl directory"; }
          { on = [ "g" "c" ];         run = "cd ~/.dotfiles";                                     desc = "go to the config directory"; }
          { on = [ "g" "d" ];         run = "cd ~/downloads";                                     desc = "go to the downloads directory"; }
          { on = [ "g" "t" ];         run = "cd /tmp";                                            desc = "go to the temporary directory"; }
          { on = [ "g" "m" ];         run = "cd ~/music/musicstagingground";                      desc = "go to the music staging ground directory"; }
          { on = [ "g" "/" ];         run = "cd /";                                               desc = "go to the root directory"; }
          { on = [ "g" "<Space>" ];   run = "cd --interactive";                                   desc = "go to a directory interactively"; }

          # help
          { on = [ "~" ];             run = "help";                                               desc = "open help"; }
        ];

        select.keymap = [
          # general
          { on = [ "<Esc>" ];         run = "close";                                              desc = "cancel selection"; }
          { on = [ "<C-[>" ];         run = "close";                                              desc = "cancel selection"; }
          { on = [ "<C-q>" ];         run = "close";                                              desc = "cancel selection"; }
          { on = [ "<Enter>" ];       run = "close --submit";                                     desc = "submit the selection"; }

          # navigation
          { on = [ "k" ];             run = "arrow -1";                                           desc = "move cursor up"; }
          { on = [ "j" ];             run = "arrow 1";                                            desc = "move cursor down"; }

          { on = [ "k" ];             run = "arrow -5";                                           desc = "move cursor up 5 lines"; }
          { on = [ "j" ];             run = "arrow 5";                                            desc = "move cursor down 5 lines"; }

          # help
          { on = [ "~" ];             run = "help";                                               desc = "open help"; }
        ];

        input.keymap = [
          # General
          { on = [ "<C-q>" ];         run = "close";                                              desc = "Cancel input"; }
          { on = [ "<Enter>" ];       run = "close --submit";                                     desc = "Submit the input"; }
          { on = [ "<Esc>" ];         run = "escape";                                             desc = "Go back the normal mode, or cancel input"; }

          # Mode
          { on = [ "i" ];             run = "insert";                                             desc = "Enter insert mode"; }
          { on = [ "a" ];             run = "insert --append";                                    desc = "Enter append mode"; }
          { on = [ "I" ];             run = [ "move -999" "insert" ];                             desc = "Move to the BOL, and enter insert mode"; }
          { on = [ "A" ];             run = [ "move 999" "insert --append" ];                     desc = "Move to the EOL, and enter append mode"; }
          { on = [ "v" ];             run = "visual";                                             desc = "Enter visual mode"; }
          { on = [ "V" ];             run = [ "move -999" "visual" "move 999" ];                  desc = "Enter visual mode and select all"; }

          # Character-wise movement
          { on = [ "h" ];             run = "move -1";                                            desc = "Move back a character"; }
          { on = [ "l" ];             run = "move 1";                                             desc = "Move forward a character"; }

          # Word-wise movement
          { on = [ "b" ];             run = "backward";                                           desc = "Move back to the start of the current or previous word"; }
          { on = [ "w" ];             run = "forward";                                            desc = "Move forward to the start of the next word"; }
          { on = [ "e" ];             run = "forward --end-of-word";                              desc = "Move forward to the end of the current or next word"; }

          # Line-wise movement
          { on = [ "H" ];             run = "move -999";                                          desc = "Move to the BOL"; }
          { on = [ "L" ];             run = "move 999";                                           desc = "Move to the EOL"; }

          # Delete
          { on = [ "<Backspace>" ];   run = "backspace";	                                        desc = "Delete the character before the cursor"; }
          { on = [ "<Delete>" ];      run = "backspace --under";                                  desc = "Delete the character under the cursor"; }

          # Kill
          { on = [ "<C-u>" ];         run = "kill bol";                                           desc = "Kill backwards to the BOL"; }
          { on = [ "<C-k>" ];         run = "kill eol";                                           desc = "Kill forwards to the EOL"; }
          { on = [ "<C-w>" ];         run = "kill backward";                                      desc = "Kill backwards to the start of the current word"; }
          { on = [ "<A-d>" ];         run = "kill forward";                                       desc = "Kill forwards to the end of the current word"; }

          # Cut/Yank/Paste
          { on = [ "d" ];             run = "delete --cut";                                       desc = "Cut the selected characters"; }
          { on = [ "D" ];             run = [ "delete --cut" "move 999" ];                        desc = "Cut until the EOL"; }
          { on = [ "c" ];             run = "delete --cut --insert";                              desc = "Cut the selected characters, and enter insert mode"; }
          { on = [ "C" ];             run = [ "delete --cut --insert" "move 999" ];               desc = "Cut until the EOL, and enter insert mode"; }
          { on = [ "x" ];             run = [ "delete --cut" "move 1 --in-operating" ];           desc = "Cut the current character"; }
          { on = [ "y" ];             run = "yank";                                               desc = "Copy the selected characters"; }
          { on = [ "p" ];             run = "paste";                                              desc = "Paste the copied characters after the cursor"; }
          { on = [ "P" ];             run = "paste --before";                                     desc = "Paste the copied characters before the cursor"; }

          # Undo/Redo
          { on = [ "u" ];             run = "undo";                                               desc = "Undo the last operation"; }
          { on = [ "U" ];             run = "redo";                                               desc = "Redo the last operation"; }

          # Help
          { on = [ "~" ];             run = "help";                                               desc = "Open help"; }
        ];

        completion.keymap = [
          { on = [ "<C-q>" ];         run = "close";                                              desc = "Cancel completion"; }
          { on = [ "<Tab>" ];         run = "close --submit";                                     desc = "Submit the completion"; }
          { on = [ "<Enter>" ];       run = [ "close --submit" "close_input --submit" ];          desc = "Submit the completion and input"; }

          { on = [ "<A-k>" ];         run = "arrow -1";                                           desc = "Move cursor up"; }
          { on = [ "<A-j>" ];         run = "arrow 1";                                            desc = "Move cursor down"; }

          { on = [ "<Up>" ];          run = "arrow -1";                                           desc = "Move cursor up"; }
          { on = [ "<Down>" ];        run = "arrow 1";                                            desc = "Move cursor down"; }

          { on = [ "<C-p>" ];         run = "arrow -1";                                           desc = "Move cursor up"; }
          { on = [ "<C-n>" ];         run = "arrow 1";                                            desc = "Move cursor down"; }

          { on = [ "~" ];             run = "help";                                               desc = "Open help"; }
        ];

        help.keymap = [
          { on = [ "<Esc>" ];         run = "escape";                                             desc = "Clear the filter, or hide the help"; }
          { on = [ "<C-[>" ];         run = "escape";                                             desc = "Clear the filter, or hide the help"; }
          { on = [ "q" ];             run = "close";                                              desc = "Exit the process"; }
          { on = [ "<C-q>" ];         run = "close";                                              desc = "Hide the help"; }

          # Navigation
          { on = [ "k" ];             run = "arrow -1";                                           desc = "Move cursor up"; }
          { on = [ "j" ];             run = "arrow 1";                                            desc = "Move cursor down"; }

          { on = [ "K" ];             run = "arrow -5";                                           desc = "Move cursor up 5 lines"; }
          { on = [ "J" ];             run = "arrow 5";                                            desc = "Move cursor down 5 lines"; }

          { on = [ "<Up>" ];          run = "arrow -1";                                           desc = "Move cursor up"; }
          { on = [ "<Down>" ];        run = "arrow 1";                                            desc = "Move cursor down"; }

          { on = [ "<S-Up>" ];        run = "arrow -5";                                           desc = "Move cursor up 5 lines"; }
          { on = [ "<S-Down>" ];      run = "arrow 5";                                            desc = "Move cursor down 5 lines"; }

          # Filtering
          { on = [ "/" ];             run = "filter";                                             desc = "Apply a filter for the help items"; }
        ];
      };
      theme = {
        icon.dirs = [ ];
        icon.exts = [
          { name = "txt";           text = "󰈙"; }
          { name = "md";            text = "󰥥"; }
          { name = "rst";           text = "󰈙"; }
          { name = "COPYING";       text = "󰿃"; }
          { name = "LICENSE";       text = "󰿃"; }

          # Archives
          { name = "zip";           text = "󰛫"; }
          { name = "tar";           text = "󰛫"; }
          { name = "gz";            text = "󰛫"; }
          { name = "7z";            text = "󰛫"; }
          { name = "bz2";           text = "󰛫"; }
          { name = "xz";            text = "󰛫"; }

          # Documents
          { name = "doc";           text = "󰈬"; }
          { name = "doct";          text = "󰈬"; }
          { name = "docx";          text = "󰈬"; }
          { name = "dot";           text = "󰈬"; }
          { name = "pdf";           text = ""; }
          { name = "pom";           text = "󰈧"; }
          { name = "pot";           text = "󰈧"; }
          { name = "ppm";           text = "󰈧"; }
          { name = "pps";           text = "󰈧"; }
          { name = "ppt";           text = "󰈧"; }
          { name = "potx";          text = "󰈧"; }
          { name = "ppmx";          text = "󰈧"; }
          { name = "ppsx";          text = "󰈧"; }
          { name = "pptx";          text = "󰈧"; }
          { name = "csv";           text = "󰈛"; }
          { name = "ods";           text = "󰈛"; }
          { name = "ots";           text = "󰈛"; }
          { name = "xlc";           text = "󰈛"; }
          { name = "xlm";           text = "󰈛"; }
          { name = "xls";           text = "󰈛"; }
          { name = "xlt";           text = "󰈛"; }
          { name = "xlsm";          text = "󰈛"; }
          { name = "xlsx";          text = "󰈛"; }

          # Audio
          { name = "mp3";           text = "󰈣"; }
          { name = "flac";          text = "󰈣"; }
          { name = "wav";           text = "󰈣"; }
          { name = "aac";           text = "󰈣"; }
          { name = "ogg";           text = "󰈣"; }
          { name = "m4a";           text = "󰈣"; }
          { name = "mp2";           text = "󰈣"; }

          # Movies
          { name = "mp4";           text = "󰈫"; }
          { name = "mkv";           text = "󰈫"; }
          { name = "avi";           text = "󰈫"; }
          { name = "mov";           text = "󰈫"; }
          { name = "webm";          text = "󰈫"; }

          # Images
          { name = "jpg";           text = "󰈟"; }
          { name = "jpeg";          text = "󰈟"; }
          { name = "png";           text = "󰈟"; }
          { name = "gif";           text = "󰈟"; }
          { name = "webp";          text = "󰈟"; }
          { name = "avif";          text = "󰈟"; }
          { name = "bmp";           text = "󰈟"; }
          { name = "ico";           text = "󰈟"; }
          { name = "svg";           text = "󰈟"; }
          { name = "xcf";           text = "󰈟"; }
          { name = "HEIC";          text = "󰈟"; }

          # Programming
          { name = "c";             text = ""; }
          { name = "cpp";           text = ""; }
          { name = "h";             text = ""; }
          { name = "hpp";           text = ""; }
          { name = "rs";            text = ""; }
          { name = "go";            text = ""; }
          { name = "py";            text = ""; }
          { name = "hs";            text = ""; }
          { name = "js";            text = ""; }
          { name = "ts";            text = ""; }
          { name = "tsx";           text = ""; }
          { name = "jsx";           text = ""; }
          { name = "rb";            text = ""; }
          { name = "php";           text = ""; }
          { name = "java";          text = ""; }
          { name = "sh";            text = ""; }
          { name = "fish";          text = ""; }
          { name = "swift";         text = ""; }
          { name = "vim";           text = ""; }
          { name = "lua";           text = ""; }
          { name = "html";          text = ""; }
          { name = "css";           text = ""; }
          { name = "sass";          text = ""; }
          { name = "scss";          text = ""; }
          { name = "json";          text = ""; }
          { name = "toml";          text = ""; }
          { name = "yml";           text = ""; }
          { name = "yaml";          text = ""; }
          { name = "ini";           text = ""; }
          { name = "conf";          text = ""; }
          { name = "lock";          text = ""; }
          { name = "nix";           text = ""; }
          { name = "Containerfile"; text = "󰡨"; }
          { name = "Dockerfile";    text = "󰡨"; }

          # Misc
          { name = "bin";           text = ""; }
          { name = "exe";           text = ""; }
          { name = "pkg";           text = ""; }
        ];
      };
      settings = {
        open.rules = [
          { mime = "inode/directory";               use = [ "directory" ]; }
          { mime = "text/*";                        use = [ "edit"      ]; }
          { mime = "application/json";              use = [ "edit"      ]; }
          { mime = "video/*";                       use = [ "video"     ]; }
          { mime = "audio/*";                       use = [ "audio"     ]; }
          { mime = "image/*";                       use = [ "image"     ]; }
          { mime = "application/pdf";               use = [ "pdf"       ]; }

          # Microsoft Office Filetypes              
          { mime = "application/msword";            use = [ "office"    ]; }
          { mime = "application/vnd.ms*";           use = [ "office"    ]; }
          { mime = "application/vnd.openx*";        use = [ "office"    ]; }

          # Open Document Filetypes
          { mime = "application/vnd.oasis.opend*";  use = [ "office"    ]; }
        ];
        opener = {
          open = [
            { run = ''nvim "$@"'';                    block = true;         desc = "neovim";      }
            { run = ''zeditor "$@"'';                 orphan = true;        desc = "Zed";         }
          ];
          edit = [                                    
            { run = ''nvim "$@"'';                    block = true;         desc = "neovim";      }
            { run = ''zeditor "$@"'';                 orphan = true;        desc = "Zed";         }
          ];
          pdf = [                                     
            { run = ''zathura "$@"'';                 orphan = true;        desc = "zathura";     }
            { run = ''zen-browser "$@"'';             orphan = true;        desc = "Zen Browser"; }
            { run = ''libreoffice "$@"'';             orphan = true;        desc = "LibreOffice"; }
            { run = ''librewolf "$@"'';               orphan = true;        desc = "LibreWolf";   }
          ];
          video = [                                   
            { run = ''mpv "$@"'';                     orphan = true;        desc = "mpv";         }
            { run = ''libreoffice "$@"'';             orphan = true;        desc = "LibreOffice"; }
          ];
          audio = [                                   
            { run = ''mpv "$@"'';                     orphan = true;        desc = "mpv";         }
            { run = ''libreoffice "$@"'';             orphan = true;        desc = "LibreOffice"; }
          ];
          image = [                                   
            { run = ''xdg-open "$@"'';                orphan = true;        desc = "swayimg";     }
            { run = ''swayimg "$@"'';                 orphan = true;        desc = "swayimg";     }
            { run = ''libreoffice "$@"'';             orphan = true;        desc = "LibreOffice"; }
          ];
          office = [                                  
            { run = ''libreoffice "$@"'';             orphan = true;        desc = "LibreOffice"; }
            { run = ''zen-browser "$@"'';             orphan = true;        desc = "Zen Browser"; }
            { run = ''librewolf "$@"'';               orphan = true;        desc = "LibreWolf";   }
          ];
          directory = [
            { run = ''foot -D "$@"'';                 orphan = true;        desc = "terminal";    }
            { run = ''nvim "$@"'';                    block = true;         desc = "neovim";      }
            { run = ''foot -e yazi "$@"'';            orphan = true;        desc = "yazi";        }
            { run = ''zeditor "$@"'';                 orphan = true;        desc = "Zed";         }
          ];
        };
        manager = {
        ratio = [1 4 3];
        sort_by = "extension";
        set_dir_first = true;
        show_symlink = true;
        scrolloff = 10;
        linemode = "mtime";
        };
      };
    };

    xdg.desktopEntries = {
      yazi = {
        name = "Yazi";
        genericName = "File Manager";
        exec = ''foot -e yazi %u'';
        terminal = true;
        categories = [ "Utility" "Core" "System" "FileTools" "FileManager" "ConsoleOnly" ];
        mimeType = [ "inode/directory" ];
      };
    };
  };
}
