local SymbolKind = vim.lsp.protocol.SymbolKind

local symbol_usage = require('symbol-usage')

local function text_format(symbol)
    if symbol.implementation then
        return {{'I', 'DiagnosticSignHint'}}
    end

    return ''
end

symbol_usage.setup({
    kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Class, SymbolKind.Struct},
    implementation = { enabled = true },
    vt_position = 'signcolumn',
    text_format = text_format
})
