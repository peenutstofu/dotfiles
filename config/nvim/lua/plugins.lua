local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here

	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" }) -- Common utilities

	-- Colorschemes
	use({ "EdenEast/nightfox.nvim" }) -- Color scheme

	use({ "goolord/alpha-nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ 'voldikss/vim-floaterm' })
	use({ "nvim-lualine/lualine.nvim" }) -- Statusline
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "kyazdani42/nvim-web-devicons" }) -- File icons
	use({ "akinsho/bufferline.nvim" })
	use({ "numToStr/Comment.nvim" })

	-- Explorer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- LSP
	use({
		"neoclide/coc.nvim",
		branch = "release",
		config = function()
			vim.cmd([[
				let g:node_host_prog = '~/scoop/apps/volta/current/appdata/tools/image/packages/neovim/lib/node_modules/neovim/bin/cli.js'
			]])
		end,
	})

	-- Git
	use({ 'TimUntersberger/neogit' })
	use({ 'lewis6991/gitsigns.nvim' })
	use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
	use({ 'kdheepak/lazygit.nvim' })

	-- which-key
	use({ 'folke/which-key.nvim' })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })
	use({ "fannheyward/telescope-coc.nvim" })
	use({ "ahmedkhalf/project.nvim" })

	-- Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({ "ellisonleao/glow.nvim" })

	-- Syntax hilight
	use({ "sheerun/vim-polyglot" })
	use({ "ziglang/zig.vim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
