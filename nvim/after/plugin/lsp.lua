local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr}
    -- lsp_zero.default_keymaps({buffer = bufnr, exclude = {'K'}})
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
    vim.keymap.set('n', 'K', function () vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gD', function () vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gi', function () vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'go', function () vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', 'gs', function () vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<F2>', function () vim.lsp.buf.rename() end, opts)
    vim.keymap.set({'n', 'x'}, '<F3>', function () vim.lsp.buf.format({async=true}) end, opts)
    vim.keymap.set('n', '<F4>', function () vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', 'gl', function () vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function () vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', ']d', function () vim.diagnostic.open_float() end, opts)
end)

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
         ['gopls'] = {'go'}
    }
})

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'gopls', 'clangd', 'lua_ls'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

local luasnip = require("luasnip")

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2, option = { show_autosnippets = true }},
    -- {name = 'cmp_luasnip'},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif vim.fn.exists("*has_words_before") == 1 and has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" })

  }),
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  }
})

