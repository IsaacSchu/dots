local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    {
      "folke/tokyonight.nvim",
      lazy = true,
      priority = 1000,
      opts = { style = "night", transparent = true, styles = { sidebars = "transparent", floats = "transparent" } },
    },
    { "nvim-telescope/telescope.nvim" },

    {
      "williamboman/mason.nvim",
      opts = { ensure_installed = { "prettier" } },
    },

    { "williamboman/mason-lspconfig.nvim", config = function() end },
    {
      "neovim/nvim-lspconfig",
      event = "BufReadPre",
    },

    { "mfussenegger/nvim-lint" },
    {
      "stevearc/conform.nvim",
      dependencies = { "mason.nvim" },
    },
    { "mfussenegger/nvim-dap" },
    { "L3mON4D3/LuaSnip" },
    {
      "joshuavial/aider.nvim",
      opts = {
        -- your configuration comes here
        -- if you don't want to use the default settings
        auto_manage_context = true, -- automatically manage buffer context
        default_bindings = true, -- use default <leader>A keybindings
        debug = false, -- enable debug logging
      },
    },

    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
vim.g.mapleader = " "
vim.g.autoformat = false
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" },
})
local lspconfig = require("lspconfig")
--local cmp = require("cmp")
require("lint").linters_by_ft = {
  markdown = { "proselint" },
}
--require("conform").setup({
--  formatters_by_ft = {
--    lua = { "stylua" },
--    -- Conform will run multiple formatters sequentially
--    python = { "ruff" },
--    -- You can customize some of the format options for the filetype (:help conform.format)
--    rust = { "rustfmt", lsp_format = "fallback" },
-- Conform will run the first available formatter
--    javascript = { "prettierd", "prettier", stop_after_first = true },
--    c = { "clang_format" },
--  },
--  format_on_save = {
--    -- These options will be passed to conform.format()
--    timeout_ms = 500,
--   lsp_format = "fallback",
--  },
--})
--cmp.setup({
--  snippet = {
--    expand = function(args)
--      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
--    end,
--  },
--  mapping = cmp.mapping.preset.insert({
--    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--    ["<C-f>"] = cmp.mapping.scroll_docs(4),
--    ["<C-Space>"] = cmp.mapping.complete(),
--    ["<C-e>"] = cmp.mapping.abort(),
--    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
--  }),
--  sources = cmp.config.sources({
--   { name = "nvim_lsp" },
--  { name = "buffer" },
--  { name = "path" },
--  { name = "cmdline" },
--  }),
--})

--
vim.keymap.set("n", "<leader>f", vim.cmd.Ex)
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
--vim.opt.guicursor = "n-v-c:block"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.cursorline = false
vim.cmd([[colorscheme tokyonight-night]])
vim.cmd([[
  highlight Normal ctermbg=none guibg=none
  highlight NonText ctermbg=none guibg=none
  highlight CmdLine guibg=NONE ctermbg=NONE
  highlight CmdLineSel guibg=NONE ctermbg=NONE
  highlight CmdLinePopup guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
]])

-- Define a command to run Python files
vim.api.nvim_set_keymap("n", "<leader>r", [[:w<CR>: !python %<CR>]], { noremap = true, silent = true })

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>d", builtin.find_files, {})
vim.keymap.set("n", "<leader>g", builtin.git_files, {})
--local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd" },
})
lspconfig.pyright.setup({
  capabilities = capabilities,
})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.o.titlestring = vim.fn.expand("%:~")
    vim.o.title = true
  end,
})
