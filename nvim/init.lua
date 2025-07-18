-- ===============================================
--          Configurações Básicas do Neovim
-- ===============================================

-- Desativa o modo compatível com o Vim para usar as funcionalidades do Neovim
vim.opt.compatible = false
-- Adiciona o diretório do vim-plug ao runtimepath para que os plugins sejam encontrados
vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. '/vim-plug')

-- ===============================================
--                 Gerenciamento de Plugins
-- ===============================================

-- Chama o vim-plug para carregar os plugins definidos em pluggins.vim
vim.cmd("source " .. vim.fn.stdpath('config') .. "/vim-plug/pluggins.vim")

-- ===============================================
--                 Opções Visuais
-- ===============================================

-- Define o esquema de cores
vim.cmd("colorscheme carbonfox")

-- Exibe os números de linha absolutos
vim.opt.number = true
-- Exibe os números de linha relativos
vim.opt.relativenumber = true
-- Destaca a linha do cursor
vim.opt.cursorline = true

-- ===============================================
--                 Mapeamentos de Teclas
-- ===============================================

-- Mapeamento para abrir a busca de arquivos (geralmente com fzf)
vim.api.nvim_set_keymap('n', '<C-f>', ':Files<CR>', { noremap = true, silent = true })
-- Mapeamento para abrir a busca com Rg (ripgrep)
vim.api.nvim_set_keymap('n', '<C-c>', ':Rg<CR>', { noremap = true, silent = true })

-- ===============================================
--                 Customização da Coluna de Status
-- ===============================================

-- Carrega o módulo Lua personalizado para a coluna de status
local statuscol_custom = require("statuscol_custom")
-- Configura a coluna de status para usar a função definida no módulo
vim.opt.statuscolumn = "%!v:lua.require('statuscol_custom').statuscolumn()"

-- ===============================================
--                 Configuração do LSP (nvim-lspconfig)
-- ===============================================

-- Carrega o módulo nvim-lspconfig
local lspconfig = require('lspconfig')

-- **Defina o nível de log globalmente para depuração AQUI**
-- Isso afeta todos os clientes LSP, mas é o que queremos para depurar agora.
vim.lsp.set_log_level("DEBUG") -- Esta linha foi adicionada/movida aqui

-- Configuração para o servidor de linguagem Python (pylsp)
lspconfig.pylsp.setup({
  -- Define o caminho exato do seu interpretador Python 3.13
  cmd = { '/usr/bin/python3.13', '-m', 'pylsp' },

  on_attach = function(client, bufnr)
    -- REMOVIDO: client.set_log_level("DEBUG") -- Esta linha causou o erro
    -- Você pode adicionar outras configurações on_attach aqui, se tiver.
  end,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = true },
        pyflakes = { enabled = true },
        jedi_completion = { enabled = true },
        jedi_definition = { enabled = true },
      },
    },
  },
})

-- ===============================================
--                 Configuração do Autocompletion (nvim-cmp)
-- ===============================================

-- Carrega os módulos necessários para nvim-cmp
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')

cmp.setup({
  -- Configuração para expansão de snippets usando vim-vsnip
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  -- Mapeamentos de teclas para interação com o menu de autocompletion
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Rola a documentação para cima
    ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Rola a documentação para baixo
    ['<C-Space>'] = cmp.mapping.complete(),  -- Inicia o autocompletion
    ['<C-e>'] = cmp.mapping.abort(),         -- Aborta o autocompletion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirma a seleção e fecha o menu
  }),
  -- Fontes de sugestão para o autocompletion
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Sugestões do Language Server Protocol
    { name = 'vsnip' },    -- Sugestões de snippets
    { name = 'buffer' },   -- Sugestões de palavras do buffer atual
    { name = 'path' },     -- Sugestões de caminhos de arquivo
  }),
})

-- Configuração do autocompletion para o modo de linha de comando (busca com /)
cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'buffer' }
  })
})

-- Configuração do autocompletion para o modo de linha de comando (comandos com :)
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },    -- Sugestões de caminhos
    { name = 'cmdline' }  -- Sugestões de comandos do histórico
  })
})
