-- Set leader key
vim.g.mapleader = " " -- Spacebar is the leader key

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Syntax highlighting & colors
vim.opt.termguicolors = true

-- Auto-reload files changed outside of Neovim
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "checktime",
})

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- nvim-comment
vim.keymap.set({ "n", "v" }, "<leader>/", ":CommentToggle<cr>")

-- Install lazy.nvim (Plugin Manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)


-- Plugins
require("lazy").setup({
  -- Navigation
  { "nvim-telescope/telescope.nvim",             dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-file-browser.nvim" }, -- File browser
  { "windwp/nvim-autopairs" },                      -- Autopairs plugin
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        disable_netrw = true,
        view = {
          width = 30,
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    --- type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- LSP & Code Assistance
  { "neovim/nvim-lspconfig" },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp",                 dependencies = { "hrsh7th/cmp-nvim-lsp" } }, -- Autocomplete
  { "github/copilot.vim" },                                                          -- AI-powered coding
  { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
  { "jose-elias-alvarez/null-ls.nvim" },                                             -- Linting & Formatting
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick",         -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua",              -- for file_selector provider fzf
  --     "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua",        -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  -- Git & Buffers
  { "lewis6991/gitsigns.nvim" },
  { "akinsho/bufferline.nvim" },
  { "tpope/vim-fugitive" }, -- Git commands

  -- UI Enhancements
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-web-devicons" }, -- Icons for Tree and Bufferline
  { "folke/tokyonight.nvim" },
  { "Mofiqul/vscode.nvim" },
  { "Skardyy/makurai-nvim" },
  { "ofseed/copilot-status.nvim" },
  { "arturgoms/moonbow.nvim" },
  -- Save and load buffers (a session) automatically for each folder
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads" },
      }
    end
  },
  -- Comment code
  {
    'terrortylor/nvim-comment',
    config = function()
      require("nvim_comment").setup()
    end
  }
})

-- Theme
vim.cmd("colorscheme vscode")
-- vim.cmd("colorscheme moonbow")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- switch panes with Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- split panes with Ctrl + /
vim.keymap.set("n", "<C-/>", ":vsplit<CR>", { silent = true })

-- split panes with Ctrl + .
vim.keymap.set("n", "<C-.>", ":split<CR>", { silent = true })

-- Lualine (Bottom Status Bar)
require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "",
    globalstatus = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      { "filename", path = 1 },
    },
    lualine_x = { "copilot" },
    lualine_y = { "filetype", "progress" },
  },
  -- extensions = { "oil" }
})

-- LSP & Autocompletion
require("mason").setup()
require("mason-lspconfig").setup({ 
	ensure_installed = { "lua_ls", "yamlls", "jsonls", "terraformls", "bashls" },
})
-- Configure Installed LSPs
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {}
lspconfig.yamlls.setup {}
lspconfig.jsonls.setup {}
lspconfig.terraformls.setup {}
lspconfig.bashls.setup {}

-- diagnostic (Show errors and warnings)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>p", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Show All Diagnostics" })

vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end

vim.keymap.set('n', '<leader>xd', Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Tell LSP that `vim` is a global variable
      },
    },
  },
})

-- Auto-completion (VS Code-like suggestions)
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
  }),
})

-- nvim-autopairs setup
local npairs = require("nvim-autopairs")
npairs.setup({
  disable_filetype = { "TelescopePrompt", "vim" },
  fast_wrap = {},
})

-- Telescope (File Searcher like Ctrl+P in VS Code)
local telescope = require("telescope")
telescope.load_extension("file_browser")
-- vim.keymap.set("n", "<leader>e", ":Telescope file_browser<CR>", { silent = true })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":Telescope find_files hidden=true<CR>", { noremap = true, silent = true }) -- Ctrl+P for find_files
vim.keymap.set("n", "<leader>g", ":Telescope git_status<CR>", { silent = true })                         -- Git status UI

-- Global marks
local set_keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local prefixes = "m'"
local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #prefixes do
  local prefix = prefixes:sub(i, i)
  for j = 1, #letters do
    local lower_letter = letters:sub(j, j)
    local upper_letter = string.upper(lower_letter)
    set_keymap("n", prefix .. lower_letter, prefix .. upper_letter, opts)
    set_keymap("v", prefix .. lower_letter, prefix .. upper_letter, opts)
  end
end
require('telescope').setup {
  pickers = {
    marks = {
      theme = "dropdown", -- Optional, can use "ivy" or "cursor" theme
    },
  },
}

vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { noremap = true, silent = true })


-- Git Integration (Shows "dot" for changed files like VS Code)
require("gitsigns").setup(
  {
    current_line_blame = true,
    vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { silent = true }),
    -- vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { silent = true }),
  }
)

-- Save with Ctrl+S
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })

-- GitHub Copilot (Enable Copilot)
vim.g.copilot_enabled = true
vim.g.copilot_filetypes = { "terraform", "python", "bash", "sh", "hcl", "yaml" }
-- vim.keymap.set("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })

-- Formatter (Prettier)
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,            -- JSON/YAML auto-formatting
    null_ls.builtins.formatting.stylua,              -- Lua formatting
    null_ls.builtins.diagnostics.shellcheck,         -- Shell script linting
    null_ls.builtins.diagnostics.terraform_validate, -- Terraform validation
    null_ls.builtins.formatting.shfmt,               -- Shell script formatting
  },
})
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- Auto-format on save

-- Bufferline (Show open buffers like VS Code)
require("bufferline").setup {}
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { silent = true })                -- Close tab
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })        -- Next tab
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })      -- Previous tab
vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { silent = true }) -- Go to tab 1
vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { silent = true }) -- Go to tab 2

-- Set font
vim.cmd("set guifont=FiraCode\\ Nerd\\ Font:h10")

-- Set background color
-- vim.cmd("set background=dark")
vim.o.background = "dark"  -- Set background to dark

vim.opt.tabstop = 2        -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2     -- Size of an indent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.number = true      -- Show line numbers
vim.opt.cursorline = true  -- Highlight current line
vim.opt.wrap = true        -- Wrap lines
vim.opt.autoindent = true  -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line

-- Icons for Bufferline and Tree
require("nvim-web-devicons").setup() -- Ensure icons are enabled

-- no highlighting after search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })

-- treesitter config for terraform python
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "terraform", "go", "markdown", "bash" }, -- List of parsers to install
  highlight = {
    enable = true,                                                               -- Enable highlighting
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true, -- Enable indentation
  },
})
