{

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>nn";
      action = ":cnext<CR>";
    }
    {
      mode = "n";
      key = "<leader>pp";
      action = ":cprev<CR>";
    }
    {
      mode = "n";
      key = "<leader>r";
      action = ":mksession! Session.vim | restart source Session.vim<CR>";
    }
    {
      action.__raw = "function() vim.lsp.buf.code_action() end";
      key = "<leader>ca";
      options = {
        silent = true;
        noremap = true;
        desc = "Code Actions";
      };
    }
    {
      action = ":m '>+1<CR>gv=gv'";
      key = "J";
      mode = "v";
      options = {
        silent = true;
        noremap = true;
        desc = "Move selection down";
      };
    }
    {
      action = ">gv";
      key = ">";
      mode = "v";
      options = {
        silent = true;
        noremap = true;
        desc = "Move selection right";
      };
    }
    {
      action = "<gv";
      key = "<";
      mode = "v";
      options = {
        silent = true;
        noremap = true;
        desc = "Move selection left";
      };
    }
    {
      action = ":m '<-2<CR>gv=gv'";
      key = "K";
      mode = "v";
      options = {
        silent = true;
        noremap = true;
        desc = "Move selection up";
      };
    }
    {
      action = "q";
      key = "q";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      action = "<C-v>";
      key = "<C-v>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      action = ":wincmd k<CR>";
      key = "<c-k>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      action = ":wincmd j<CR>";
      key = "<c-j>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      action = ":wincmd h<CR>";
      key = "<c-h>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      action = ":wincmd l<CR>";
      key = "<c-l>";
      options = {
        silent = true;
        noremap = true;
      };
    }
  ];
}
