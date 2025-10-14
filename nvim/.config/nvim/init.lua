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

-- Comment toggle
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
  -- Copilot Chat (adds chat panel without changing your Copilot engine)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local chat = require("CopilotChat")
      chat.setup({
        context = "buffers", -- use all open buffers by default
      })
      -- Keys similar to VS Code feel
      vim.keymap.set("n", "<leader>cc", function() chat.toggle() end, { desc = "CopilotChat - Toggle" })
      vim.keymap.set({"n","v"}, "<leader>ca", function() chat.ask() end, { desc = "CopilotChat - Ask (with selection)" })
      vim.keymap.set("n", "<leader>cr", function() chat.reset() end, { desc = "CopilotChat - Reset" })
      vim.keymap.set("n", "<leader>ch", function() chat.help() end, { desc = "CopilotChat - Help" })
    end,
  },
})

-- Theme
vim.cmd("colorscheme vscode")

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
      theme = "dropdown",
    },
  },
}

vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { noremap = true, silent = true })

-- Git Integration (Shows "dot" for changed files like VS Code)
require("gitsigns").setup(
  {
    current_line_blame = true,
    vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { silent = true }),
  }
)

-- Save with Ctrl+S
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })

-- GitHub Copilot (Enable Copilot)
vim.g.copilot_enabled = true
vim.g.copilot_filetypes = { "terraform", "python", "bash", "sh", "hcl", "yaml" }
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })

-- Formatter / Linting via none-ls (module name is 'null-ls')
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,            -- JSON/YAML/JS formatting
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

-- Set font (only applies to GUIs like neovide/ goneovim)
vim.cmd("set guifont=FiraCode\\ Nerd\\ Font:h10")

-- Dark background
vim.o.background = "dark"

-- Indentation & formatting basics
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Icons for Bufferline and Tree
require("nvim-web-devicons").setup()
