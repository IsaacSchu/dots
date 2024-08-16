vim.g.mapleader = " "
require("config.lazy")
--require("lazy").setup({{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}})
require("mason").setup()
local lspconfig = require("lspconfig")
require('lint').linters_by_ft = {
    markdown = { 'vale', 'selene', 'cpplint', 'ruff' }
}
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "ruff" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        c = { "clang_format" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
--
vim.keymap.set("n", "<leader>f", vim.cmd.Ex)
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.opt.guicursor = "n-v-c:block"
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
vim.cmd [[colorscheme tokyonight-night]]
vim.cmd [[
  highlight Normal ctermbg=none guibg=none
  highlight NonText ctermbg=none guibg=none
  highlight CmdLine guibg=NONE ctermbg=NONE
  highlight CmdLineSel guibg=NONE ctermbg=NONE
  highlight CmdLinePopup guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
]]

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>d', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.git_files, {})

--local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = { "clangd" }
})
lspconfig.pyright.setup({})
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}
