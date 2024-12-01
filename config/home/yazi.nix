{ pkgs, ... }: {

  xdg.desktopEntries = {
    yazi = {
      name = "Yazi";
      genericName = "File Manager";
      exec = "yazi %u";
      terminal = true;
      categories = [ "Utility" "Core" "System" "FileTools" "FileManager" "ConsoleOnly" ];
      mimeType = [ "inode/directory" ];
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {
      manager.keymap = [
        # General
        { on = [ "<esc>" ];         run = "escape";                                             desc = "exit visual mode, clear selected, or cancel search"; }
        { on = [ "q" ];             run = "quit";                                               desc = "exit the process"; }
        { on = [ "q" ];             run = "quit --no-cwd-file";                                 desc = "exit the process without writing cwd-file"; }
        { on = [ "<c-q>" ];         run = "close";                                              desc = "close the current tab, or quit if it is last tab"; }
        { on = [ "<c-z>" ];         run = "suspend";                                            desc = "suspend the process"; }

        # navigation
        { on = [ "k" ];             run = "arrow -1";                                           desc = "move cursor up"; }
        { on = [ "j" ];             run = "arrow 1";                                            desc = "move cursor down"; }

        { on = [ "k" ];             run = "arrow -5";                                           desc = "move cursor up 5 lines"; }
        { on = [ "j" ];             run = "arrow 5";                                            desc = "move cursor down 5 lines"; }

        { on = [ "<c-k>" ];         run = "arrow -50%";                                         desc = "move cursor up half page"; }
        { on = [ "<c-j>" ];         run = "arrow 50%";                                          desc = "move cursor down half page"; }

        { on = [ "h" ];             run = "leave";                                              desc = "go back to the parent directory"; }
        { on = [ "l" ];             run = "enter";                                              desc = "enter the child directory"; }

        { on = [ "<" ];             run = "seek -5";                                            desc = "seek up 5 units in the preview"; }
        { on = [ ">" ];             run = "seek 5";                                             desc = "seek down 5 units in the preview"; }

        { on = [ "g" "g" ];         run = "arrow -99999999";                                    desc = "move cursor to the top"; }
        { on = [ "g" ];             run = "arrow 99999999";                                     desc = "move cursor to the bottom"; }

        # selection
        { on = [ "<space>" ];       run = [ "select --state=none" "arrow 1" ];                  desc = "toggle the current selection state"; }
        { on = [ "v" ];             run = "visual_mode";                                        desc = "enter visual mode (selection mode)"; }
        { on = [ "v" ];             run = "visual_mode --unset";                                desc = "enter visual mode (unset mode)"; }
        { on = [ "<c-a>" ];         run = "select_all --state=true";                            desc = "select all files"; }
        { on = [ "<c-r>" ];         run = "select_all --state=none";                            desc = "inverse selection of all files"; }

        # operation
        { on = [ "<enter>" ];       run = "open";                                               desc = "open the selected files"; }
        { on = [ "<c-enter>" ];     run = "open --interactive";                                 desc = "open the selected files interactively"; }
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
        { on = [ "g" "<space>" ];   run = "cd --interactive";                                   desc = "go to a directory interactively"; }

        # help
        { on = [ "~" ];             run = "help";                                               desc = "open help"; }
          ];

          select.keymap = [
        # general
        { on = [ "<esc>" ];         run = "close";                                              desc = "cancel selection"; }
        { on = [ "<c-[>" ];         run = "close";                                              desc = "cancel selection"; }
        { on = [ "<c-q>" ];         run = "close";                                              desc = "cancel selection"; }
        { on = [ "<enter>" ];       run = "close --submit";                                     desc = "submit the selection"; }

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
    # theme = {
    #   manager = {
    #     cwd = { fg = "#83a598"; };
    #
    #     # Hovered
    #     hovered         = { fg = "#282828"; bg = "#83a598"; };
    #     preview_hovered = { underline = true; };
    #
    #     # Find
    #     find_keyword  = { fg = "#b8bb26"; italic = true; };
    #     find_position = { fg = "#fe8019"; bg = "reset"; italic = true; };
    #
    #     # Marker
    #     marker_selected = { fg = "#b8bb26"; bg = "#b8bb26"; };
    #     marker_copied   = { fg = "#b8bb26"; bg = "#b8bb26"; };
    #     marker_cut      = { fg = "#fb4934"; bg = "#fb4934"; };
    #
    #     # Tab
    #     tab_active   = { fg = "#282828"; bg = "#504945"; };
    #     tab_inactive = { fg = "#a89984"; bg = "#3c3836"; };
    #     tab_width    = 1;
    #
    #     # Border
    #     border_symbol = "│";
    #     border_style  = { fg = "#665c54"; };
    #   };
    #   status = {
    #     separator_open  = "";
    #     separator_close = "";
    #     separator_style = { fg = "#3c3836"; bg = "#3c3836"; };
    #
    #     # Mode
    #     mode_normal = { fg = "#282828"; bg = "#A89984"; bold = true; };
    #     mode_select = { fg = "#282828"; bg = "#b8bb26"; bold = true; };
    #     mode_unset  = { fg = "#282828"; bg = "#d3869b"; bold = true; };
    #
    #     # Progress
    #     progress_label  = { fg = "#ebdbb2"; bold = true; };
    #     progress_normal = { fg = "#504945"; bg = "#3c3836"; };
    #     progress_error  = { fg = "#fb4934"; bg = "#3c3836"; };
    #
    #     # Permissions
    #     permissions_t = { fg = "#504945"; };
    #     permissions_r = { fg = "#b8bb26"; };
    #     permissions_w = { fg = "#fb4934"; };
    #     permissions_x = { fg = "#b8bb26"; };
    #     permissions_s = { fg = "#665c54"; };
    #   };
    #   input = {
    #     border   = { fg = "#bdae93"; };
    #     title    = {};
    #     value    = {};
    #     selected = { reversed = true; };
    #   };
    #   select = {
    #     border   = { fg = "#504945"; };
    #     active   = { fg = "#fe8019"; };
    #     inactive = {};
    #   };
    #   tasks = {
    #     border  = { fg = "#504945"; };
    #     title   = {};
    #     hovered = { underline = true; };
    #   };
    #   which = {
    #     mask            = { bg = "#3c3836"; };
    #     cand            = { fg = "#83a598"; };
    #     rest            = { fg = "#928374"; };
    #     desc            = { fg = "#fe8019"; };
    #     separator       = "  ";
    #     separator_style = { fg = "#504945"; };
    #   };
    #   help = {
    #     on      = { fg = "#fe8019"; };
    #     exec    = { fg = "#83a598"; };
    #     desc    = { fg = "#928374"; };
    #     hovered = { bg = "#504945"; bold = true; };
    #     footer  = { fg = "#3c3836"; bg = "#a89984"; };
    #   };
    #   filetype = {
    #     rules = [
    #       # Images
    #       { fg = "#83a598"; mime = "image/*"; }
    #      
    #       # Videos
    #       { fg = "#b8bb26"; mime = "video/*"; }
    #       { fg = "#b8bb26"; mime = "audio/*"; }
    #      
    #       # Archives
    #       { fg = "#fe8019"; mime = "application/zip"; }
    #       { fg = "#fe8019"; mime = "application/gzip"; }
    #       { fg = "#fe8019"; mime = "application/x-tar"; }
    #       { fg = "#fe8019"; mime = "application/x-bzip"; }
    #       { fg = "#fe8019"; mime = "application/x-bzip2"; }
    #       { fg = "#fe8019"; mime = "application/x-7z-compressed"; }
    #       { fg = "#fe8019"; mime = "application/x-rar"; }
    #      
    #       # Fallback
    #       { fg = "#a89984"; name = "*"; }
    #       { fg = "#83a598"; name = "*/"; }
	   #    ];
    #   };
    # };
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

  home.packages = with pkgs; [
    yazi
  ];

}
