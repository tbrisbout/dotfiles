-- TODO
--
--   Tests
--     - Run test (current file / alternate file / full suite)
--     - Show coverage
--
--   Formatting
--     - On save: prettier / fmt (goimports)
--
--   Editing
--     - Close HTML tags?
--
--   Git
--     - git signs key mappings (preview)
--     - Git diff/stage/commit
--
--   Terminal
--     - run in terminal
--     - open in insert mode
--     - quickly close term
--
--   Maintenance
--     - organize this file/split
--
--   Snippets
--     - Configure some snippets for luasnip

-- Global config
if not vim.env.TMUX then
  vim.o.termguicolors = true
end

vim.o.mouse = 'a'
vim.o.syntax = 'on'
vim.o.swapfile = false
vim.o.laststatus = 0
vim.o.showcmd = false
vim.o.showmode = false
vim.o.ruler = false
vim.o.splitbelow = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.background = 'dark'
vim.o.list = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.listchars = { tab = '· ', trail = '·', nbsp = '·' }
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- mappings

local function nnoremap(lhs, rhs, options)
	vim.keymap.set('n', lhs, rhs, options or { silent = true })
end

local function leader(lhs, rhs, options)
	vim.keymap.set({'n', 'v'}, '<leader>'..lhs, rhs, options or { silent = true })
end

local function inoremap(lhs, rhs, options)
	vim.keymap.set('i', lhs, rhs, options or { silent = true })
end

nnoremap('<space>', '')
vim.g.mapleader = ' '

leader('y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y', { silent = true })
leader('p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p', { silent = true })
leader('P', '"+P')
vim.keymap.set('v', '<leader>P', '"+P', { silent = true })

-- vertically center search
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')

leader('bd', ':bd<cr>')
leader('O', 'ko<esc>j')
leader('o', 'o<esc>k')
leader('w', ':silent write<cr>')
leader('noh', ':noh<cr>')
leader('noh', ':noh<cr>')
leader('ev', ':e $MYVIMRC<cr>')
leader(',', 'm`A,<esc>``')
leader(';', 'm`A;<esc>``')
leader('c', 'gcc', { remap = true })
vim.keymap.set('v', '<leader>c', 'gc', { remap = true })

inoremap('jj', '<esc>')
inoremap('jk', '<esc>:w<cr>')
inoremap('kj', '<esc>:w<cr>')

-- TODO check if I can/should move this to plugin setup
nnoremap('<F2>', ':NvimTreeToggle<cr>')
nnoremap('<F3>', ':NvimTreeFindFileToggle<cr>')
nnoremap('<F4>', ':CodeCompanionChat Toggle<cr>')

leader('I', ':lua vim.diagnostic.open_float()<cr>')

-- plugins

-- Install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate' },
  'shaunsingh/nord.nvim',
  'bluz71/vim-nightfly-colors',

  'tpope/vim-commentary',
  'm4xshen/autoclose.nvim',

  'lewis6991/gitsigns.nvim',
  'tpope/vim-fugitive',

  'ray-x/go.nvim',
  'ray-x/guihua.lua',

  'neovim/nvim-lspconfig',
  'williamboman/nvim-lsp-installer',

  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  'L3MON4D3/LuaSnip',

  'hrsh7th/nvim-cmp',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',

  'folke/trouble.nvim',

  'folke/zen-mode.nvim',
  'folke/twilight.nvim',

  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown", "codecompanion" },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    config = true
  }
})

vim.cmd [[colorscheme nightfly]]

require('nvim-tree').setup()
require('lualine').setup({
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diagnostics'},
    lualine_c = { {'filename', path = 1} },
    lualine_x = {'searchcount', 'branch'},
    lualine_y = {'diff'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},

})
require('autoclose').setup()

require('go').setup()

require('nvim-treesitter.configs').setup {
	ensure_installed = { "go", "rust", "typescript", "javascript", "lua", "bash" },
	highlight = {
		enable = true,
	},
}

require('gitsigns').setup({
	on_attach = function(bufnr)
		-- check this pattern
	  local gs = package.loaded.gitsigns

		leader('gn', gs.next_hunk, { buffer = bufnr })
		leader('gp', gs.prev_hunk, { buffer = bufnr })
		leader('gr', gs.reset_hunk, { buffer = bufnr })
	end
})

local ts_actions = require 'telescope.actions'

require('telescope').setup {
	defaults = {
		prompt_prefix = ' ',
		layout_config = {
			horizontal = {
				prompt_position = 'top',
				height = 0.5,
				preview_cutoff = 120,
			},
		},
		mappings = {
			i = {
				["<esc>"] = ts_actions.close,
				["<C-K>"] = ts_actions.move_selection_previous,
				["<C-I>"] = ts_actions.move_selection_next,
			},
		},
	},
}

local telescope = require 'telescope.builtin'

local function find_in_folder()
	telescope.find_files({ cwd = vim.fn.expand('%:p:h') })
end

local function open_alternate_file()
	-- TODO support other patterns than `_test`
	local alternate_pattern = "_test"

	local file_extension = "." .. vim.fn.expand("%:e")
  local file_base_name = vim.fn.expand("%:r")

	local alternate_file
	if vim.endswith(file_base_name, alternate_pattern) then
		alternate_file = file_base_name:sub(1, -#alternate_pattern - 1) .. file_extension
	else
		alternate_file = file_base_name .. alternate_pattern .. file_extension
	end

	vim.cmd("edit " .. alternate_file)
end

local function show_buffers()
	telescope.buffers { ignore_current_buffer = true, sort_mru = true }
end

leader('s', open_alternate_file)

nnoremap('<C-P>', telescope.find_files)
nnoremap('<C-K>', telescope.commands)
leader('<leader>', show_buffers)
leader('.', find_in_folder)
leader('gs', telescope.git_status)
leader('fg', telescope.live_grep)
leader('h', telescope.help_tags)
leader('K', telescope.grep_string)
leader('reg', telescope.registers)
leader('gor', telescope.lsp_dynamic_workspace_symbols)
leader('goi', telescope.lsp_implementations)

leader('vca', vim.lsp.buf.code_action)

-- TODO chose between the better use of map below
leader('god', telescope.diagnostics)
-- leader('god', telescope.treesitter)

local lspconfig = require 'lspconfig'

require('nvim-lsp-installer').setup()

local cmp = require 'cmp'
local ls = require 'luasnip'

cmp.setup({
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function on_attach()
	nnoremap('K', vim.lsp.buf.hover, { buffer = true })
	nnoremap('<C-]>', vim.lsp.buf.definition, { buffer = true })
	leader('gd', vim.lsp.buf.definition, { buffer = true })
	leader('gor', vim.lsp.buf.references, { buffer = true })
end

local common_lsp_config = {
  on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig.gopls.setup(common_lsp_config)
lspconfig.rust_analyzer.setup(common_lsp_config)
lspconfig.tsserver.setup(common_lsp_config)
lspconfig.tailwindcss.setup(common_lsp_config)
lspconfig.eslint.setup(common_lsp_config)
lspconfig.bashls.setup(common_lsp_config)


-- global diagnostics behavior
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = false,
})

local trouble = require('trouble')
trouble.setup({
  auto_preview = false,
  auto_close = true,
})

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    },
    agent = {
      adapter = "ollama",
    },
  },
})

-- abbreviations

vim.cmd 'iabbrev lenght length'
vim.cmd 'iabbrev heigth height'
vim.cmd 'iabbrev widht width'
vim.cmd 'iabbrev fucntion function'
vim.cmd 'iabbrev funciton function'
vim.cmd 'iabbrev retunr return'
vim.cmd 'iabbrev reutrn return'
vim.cmd 'iabbrev fitler filter'

vim.cmd 'cabbrev cc CodeCompanion'


-- autocmds
-- TODO check if we still need to wrap in a group

local group_id = vim.api.nvim_create_augroup('my_autocommands', {})

-- run gofmt / ...
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group_id,
  pattern = { "*.go", "*.rs" },
  callback = function()
	  vim.lsp.buf.format({ timeout_ms = 3000 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group_id,
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.cmd 'EslintFixAll'
  end,
})

-- show diagnostics in loclist after writing the file (like linting in ALE or Syntastic)
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group_id,
  pattern = { "*.go", "*.rs", "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    if not vim.tbl_isempty(vim.diagnostic.get(0)) then
      trouble.open('diagnostics')
    end
  end,
})

-- run goimports
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group_id,
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
		params.context = {only = {"source.organizeImports"}}

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

local js_ts_file_types = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

-- TODO use a better prettier implem with an LSP wrapper
-- This will replace the file with an error if there is a problem, and can lose cursor position
local function run_prettier()
  if vim.tbl_contains(js_ts_file_types, vim.bo.filetype) then
    local filepath = vim.api.nvim_buf_get_name(0)

    -- prettier does not support files with brackets (like files with param in Next.js)
    filepath = filepath:gsub('%[', '\\[')
    filepath = filepath:gsub('%]', '\\]')

    local prettier = vim.env.PRETTIER_PATH or "./node_modules/.bin/prettier"
    vim.cmd('%!' .. prettier .. ' --stdin-filepath ' .. filepath)
  end
end

leader("ff", run_prettier)

-- TODO improve the function for other filetypes
local function run_tests()
	if vim.bo.filetype == 'go' then
		vim.cmd [[
		terminal go test -v %:p:h | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/''
		]]
  elseif vim.tbl_contains(js_ts_file_types, vim.bo.filetype) then
    -- NOTE: `--bail` and `--watchAll` assume jest is the test runner
    vim.cmd [[
    terminal npm test --silent -- --bail --watchAll=false %:p:h
    ]]
	end
end

leader('t', run_tests)

-- snippets
ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI"
}

require("luasnip.loaders.from_lua").load({paths = "./snippets"})

-- jump to editable fields
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
