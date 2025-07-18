call plug#begin('~/.config/nvim/autoload/plugged')

	Plug 'wbthomason/packer.nvim'
	Plug 'tpope/vim-commentary'
	Plug 'EdenEast/nightfox.nvim'
	Plug 'kelly-lin/ranger.nvim'
	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/fzf'

	" CMP (autocomplete)	
	Plug 'hrsh7th/nvim-cmp'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/cmp-vsnip'
    	Plug 'hrsh7th/vim-vsnip'



call plug#end()
