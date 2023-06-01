--- lazy loader package manager ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

--- set up all our plugins ---

local plugins = {
	{
		"morhetz/gruvbox",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"nvim-lua/plenary.nvim"
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{mode = "n", "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find file"},
			{mode = "n", "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Live grep"},
		}
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ mode = "n", "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		config = function()
			require("neo-tree").setup()
		end,
	},
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  init = function()
	    vim.o.timeout = true
	    vim.o.timeoutlen = 100
	  end,
	  opts = {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	  },
	  keys = {"<space>"}
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"jose-elias-alvarez/null-ls.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		build = ":MasonUpdate",
		lazy = false,
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		{'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
		},
		keys = {
			{mode = "n", "<tab>", "<cmd>BufferNext<cr>", desc = "Next Tab"},
			{mode = "n", "<S-tab>", "<cmd>BufferPrev<cr>", desc = "Prev Tab"},
		}
	},
	}
}

local options = {}

--- collect plugins then lazy load them ---
require("lazy").setup(plugins, options)

--- load must-have plugins ---
local mason = require("mason").setup()
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
