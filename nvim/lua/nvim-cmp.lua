-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- ESTA LINHA É CRÍTICA E FOI A PRIMEIRA QUE DETECTAMOS COMO PROBLEMA NO SEU CÓDIGO!
-- Certifique-se de que ela está aqui e não comentada.
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').pylsp.setup {
  capabilities = cmp_capabilities,
  settings = {
    pylsp = {
      configurationSources = {"flake8"}, -- Indica que Flake8 é uma fonte de configuração
      plugins = {
        -- Habilita e configura os plugins
        flake8 = {
          enabled = true,
          maxLineLength = 88, -- Exemplo: Define o comprimento máximo da linha (padrão do Black)
          ignore = {'E203', 'W503'}, -- Exemplo: Ignora avisos específicos
        },
        autopep8 = {
          enabled = true,
          -- args = {"--aggressive", "--aggressive"} -- Exemplo: para formatar mais agressivamente
        },
        -- Se for usar YAPF, descomente abaixo e comente o autopep8 acima:
        -- yapf = {
        --    enabled = true,
        --    -- settings para yapf
        -- },
        isort = {
          enabled = true,
        },
        -- Outros plugins que podem vir habilitados por padrão, mas você pode desabilitar
        mccabe = { enabled = false }, -- Métrica de complexidade ciclomática, pode ser demais para iniciantes
        pyflakes = { enabled = false }, -- Flake8 já inclui muitas das verificações do Pyflakes
        yapf = { enabled = false }, -- Desabilite se estiver usando autopep8
        black = { enabled = false }, -- Desabilite se estiver usando autopep8/yapf
      }
    }
  }
}
