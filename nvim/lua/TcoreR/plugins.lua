local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here
    --
    use({ 'rose-pine/neovim', as = 'rose-pine' }) -- color scheme
    use {'nvim-telescope/telescope.nvim', tag = '0.1.1',requires = {{'nvim-lua/plenary.nvim'}}} -- find files
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}) -- highlight code
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon') -- switch files quick
    use('mbbill/undotree') -- undo branches and more
    use("terrortylor/nvim-comment") -- nvim-comment


    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
    }
}

use('tpope/vim-fugitive') -- git helper
use('airblade/vim-gitgutter') -- git helper
--
--
if packer_bootstrap then
    require('packer').sync()
end
end)
