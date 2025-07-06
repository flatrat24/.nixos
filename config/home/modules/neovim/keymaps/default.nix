{ ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
    keymaps = [
      ##--- Window Management ---##
      { mode = [ "n" ]; key = "<C-h>"; action = "<C-w>h"; options = { noremap = true; silent = true; desc = "Move Window Focus Left"; }; }
      { mode = [ "n" ]; key = "<C-j>"; action = "<C-w>j"; options = { noremap = true; silent = true; desc = "Move Window Focus Down"; }; }
      { mode = [ "n" ]; key = "<C-k>"; action = "<C-w>k"; options = { noremap = true; silent = true; desc = "Move Window Focus Up"; }; }
      { mode = [ "n" ]; key = "<C-l>"; action = "<C-w>l"; options = { noremap = true; silent = true; desc = "Move Window Focus Right"; }; }
      { mode = [ "n" ]; key = "<C-m>"; action = "<C-w>v"; options = { noremap = true; silent = true; desc = "Open Window Horizontally Split"; }; }
      { mode = [ "n" ]; key = "<C-n>"; action = "<C-w>s"; options = { noremap = true; silent = true; desc = "Open Window Vertically Split"; }; }
      { mode = [ "n" ]; key = "<C-q>"; action = "<C-w>q"; options = { noremap = true; silent = true; desc = "Close Focused Window"; }; }
      { mode = [ "n" ]; key = "<C-S-k>"; action = "<cmd>resize +2<CR>"; options = { noremap = true; silent = true; desc = "Horizontally Shrink Focused Window"; }; }
      { mode = [ "n" ]; key = "<C-S-j>"; action = "<cmd>resize -2<CR>"; options = { noremap = true; silent = true; desc = "Vertically Shrink Focused Window"; }; }
      { mode = [ "n" ]; key = "<C-S-h>"; action = "<cmd>vertical resize -2<CR>"; options = { noremap = true; silent = true; desc = "Horizontally Grow Focused Window"; }; }
      { mode = [ "n" ]; key = "<C-S-l>"; action = "<cmd>vertical resize +2<CR>"; options = { noremap = true; silent = true; desc = "Vertically Grow Focused Window"; }; }

      ##--- Code Folding ---##
      { mode = [ "n" ]; key = "zl"; action = "zo"; options = { noremap = true; silent = true; desc = "Open Fold Under Cursor"; }; }
      { mode = [ "n" ]; key = "zL"; action = "zO"; options = { noremap = true; silent = true; desc = "Open All Folds Under Cursor"; }; }
      { mode = [ "n" ]; key = "zO"; action = "zR"; options = { noremap = true; silent = true; desc = "Open All Folds"; }; }
      { mode = [ "n" ]; key = "zh"; action = "zc"; options = { noremap = true; silent = true; desc = "Close Fold"; }; }
      { mode = [ "n" ]; key = "zH"; action = "zC"; options = { noremap = true; silent = true; desc = "Close All Folds Under Cursor"; }; }
      { mode = [ "n" ]; key = "zC"; action = "zM"; options = { noremap = true; silent = true; desc = "Close All Folds"; }; }

      ##--- Miscellaneous ---##
      { mode = [ "n" ]; key = "U"; action = "<C-r>"; options = { noremap = true; silent = true; desc = "Redo"; }; }
      { mode = [ "x" ]; key = ">"; action = ">gv"; options = { noremap = true; silent = true; desc = "Increase line indent"; }; }
      { mode = [ "x" ]; key = "<"; action = "<gv"; options = { noremap = true; silent = true; desc = "Decrease line indent"; }; }

      ##--- View Management ---##
      # { mode = [ "n" ]; key = "<C-k>"; action = "<C-u>"; options = { noremap = true; silent = true; desc = "Move Screen Up"; }; }
      # { mode = [ "n" ]; key = "<C-j>"; action = "<C-d>"; options = { noremap = true; silent = true; desc = "Move Screen Down"; }; }
      { mode = [ "n" ]; key = "<C-;>"; action = "<C-y>"; options = { noremap = true; silent = true; desc = "Move Screen Up"; }; }
      { mode = [ "n" ]; key = "<C-'>"; action = "<C-e>"; options = { noremap = true; silent = true; desc = "Move Screen Down"; }; }
      { mode = [ "n" ]; key = "<leader>vh"; action = "<cmd>nohl<CR>"; options = { noremap = true; silent = true; desc = "Toggle Highlighting"; }; }
      { mode = [ "n" ]; key = "<leader>vs"; action = "<cmd>set spell!<CR>"; options = { noremap = true; silent = true; desc = "Toggle Spellcheck"; }; }
      { mode = [ "n" ]; key = "<leader>vw"; action = "<cmd>set wrap!<CR>"; options = { noremap = true; silent = true; desc = "Toggle Line Wrap"; }; }

      ##--- Buffer Management ---##
      { mode = [ "n" ]; key = "<leader>fw"; action = "<cmd>w<CR>"; options = { noremap = true; silent = true; desc = "Write Current Buffer"; }; }
      { mode = [ "n" ]; key = "<leader>fn"; action = "<cmd>enew<CR>"; options = { noremap = true; silent = true; desc = "Open Empty Buffer"; }; }
      { mode = [ "n" ]; key = "<leader>fW"; action = "<cmd>wa<CR>"; options = { noremap = true; silent = true; desc = "Write All Buffers"; }; }
      { mode = [ "n" ]; key = "<leader>fq"; action = "<cmd>wq<CR>"; options = { noremap = true; silent = true; desc = "Write Current Buffer and Quit"; }; }
      { mode = [ "n" ]; key = "<leader>fQ"; action = "<cmd>wa<CR><cmd>q<CR>"; options = { noremap = true; silent = true; desc = "Write All Buffers and Quit"; }; }
      { mode = [ "n" ]; key = "<leader>fn"; action = "<cmd>enew<CR>"; options = { noremap = true; silent = true; desc = "New Buffer"; }; }

      ##--- Movement ---##
      { mode = [ "n" "x" "o" ]; key = "L"; action = "$"; options = { noremap = true; silent = true; desc = "Go to End of Line"; }; }
      { mode = [ "n" "x" "o" ]; key = "H"; action = "0"; options = { noremap = true; silent = true; desc = "Go to Front of Line"; }; }
      { mode = [ "n" "x" "o" ]; key = ","; action = ";"; options = { noremap = true; silent = true; desc = "Repeat Find in Line"; }; } # TODO: Make it work in across all modes relevant
      { mode = [ "n" "x" "o" ]; key = "<tab>"; action = "%"; options = { noremap = true; silent = true; desc = "Move to Twin Bracket"; }; }
    ];
  };
}
