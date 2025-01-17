local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local options = {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require "packer.util".float { border = "single" }
    end,
  },
}

return require('packer').startup(function(use)
  require('packer').init(options)

  use 'wbthomason/packer.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require "plugins.treesitter"
    end,
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.lspconfig"
    end,
  }
  use {
    "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    config = function()
      require "plugins.mason"
    end,
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require "plugins.mason_lspconfig"
    end,
  }
  use { 'simrat39/rust-tools.nvim',
    after = "mason-lspconfig.nvim",
    config = function()
      require "rust-tools".setup()
    end,
  }
  use "rafamadriz/friendly-snippets"
  use {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require "plugins.cmp"
    end,
  }
  use {
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    requires = "onsails/lspkind.nvim",
    config = function()
      require "plugins.luasnip"
    end,
  }
  use {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  }
  use {
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  }
  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  }
  -- use {
  --   'hrsh7th/cmp-nvim-lsp-signature-help',
  --   after = "cmp-nvim-lsp",
  -- }
  use {
    "hrsh7th/cmp-path",
    after = "cmp-nvim-lsp",
  }
  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup()
    end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    after = "nvim-treesitter",
    config = function()
      require "plugins.blankline"
    end,
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require "gitsigns".setup()
    end
  }
  use "junegunn/vim-easy-align"
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require "neoscroll".setup()
    end,
  }
  use {
    "mfussenegger/nvim-dap",
    config = function()
      require "plugins.dap"
    end,
  }
  use {
    'mfussenegger/nvim-dap-python',
    after = "nvim-dap",
    config = function()
      require "dap-python".setup('python')
    end,
  }
  use {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require "plugins.dapui"
    end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
        require "Comment".setup()
    end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require "colorizer".setup()
    end
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require "plugins.bufferline"
    end
  }
  use {
    "luukvbaal/nnn.nvim",
    config = function()
      require("nnn").setup()
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "todo-comments".setup()
    end
  }
  use "chaoren/vim-wordmotion"
  use {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
      vim.keymap.set('n', 'f', '<Plug>(leap-forward)', {})
      vim.keymap.set('n', 'F', '<Plug>(leap-backward)', {})
    end,
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.trouble")
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    after = "trouble.nvim",
    config = function()
      require "plugins.telescope"
    end
  }
  use {
    "kiyoon/jupynium.nvim",
    run = "pip3 install --user .",
    config = function()
      require "plugins.jupynium"
    end
  }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    after = "trouble.nvim",
    run = ":CatppuccinCompile",
    config = function()
      require "plugins.catppuccin"
    end
  }
  use {
    "LeonHeidelbach/trailblazer.nvim",
    after = "catppuccin",
    config = function()
        require("plugins.trailblazer")
    end
  }

  if packer_bootstrap then
    require "packer".sync()
  end
end)
