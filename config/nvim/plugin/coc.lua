local coc_extensions = {
  "coc-pyright",
  "coc-json",
  "coc-emmet",
  "coc-tsserver",
  "coc-css",
  "coc-html",
  "coc-eslint",
  "coc-prettier",
  "coc-sumneko-lua",
}
if vim.fn.has("win32") == 1 then
  table.insert(coc_extensions, "coc-powershell")
else
  table.insert(coc_extensions, "coc-sh")
end

vim.g.coc_global_extensions = coc_extensions

local keymap = vim.api.nvim_set_keymap

-- Use tab to cycle trough completions and cr to confirm
keymap("i", "<tab>", "coc#pum#visible() ? coc#pum#next(1) : '<tab>'", { expr = true, noremap = true })
keymap("i", "<s-tab>", "coc#pum#visible() ? coc#pum#prev(1) : '<s-tab>'", { expr = true, noremap = true })
keymap("i", "<cr>", "coc#pum#visible() ? coc#pum#confirm() : '<cr>'", { expr = true, noremap = true })

keymap("i", "<cr>", "coc#pum#visible() ? coc#pum#confirm() : '<cr>'", { expr = true, noremap = true })

-- Show context action with Alt + ctrl
keymap("n", "<M-cr>", "<cmd>call CocActionAsync('codeAction', 'cursor')<CR>", { noremap = true, silent = false })
keymap("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true, noremap = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keymap("n", "[g", "<Plug>(coc-diagnostic-prev)", { noremap = true, silent = false })
keymap("n", "]g", "<Plug>(coc-diagnostic-next)", { noremap = true, silent = false })

-- GoTo code navigation.
-- keymap("n", "gd", "<Plug>(coc-definition)", { noremap = true, silent = false })
-- keymap("n", "gy", "<Plug>(coc-type-definition)", { noremap = true, silent = false })
-- keymap("n", "gi", "<Plug>(coc-implentation)", { noremap = true, silent = false })
-- keymap("n", "gr", "<Plug>(coc-references)", { noremap = true, silent = false })

--  Use K to show documentation in preview window.
keymap("n", "K", "<cmd>:call ShowDocumentation()<cr>", { noremap = true, silent = false })
vim.cmd([[
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
]])

-- Highlight the symbol and its references when holding the cursor.
vim.cmd([[
autocmd CursorHold * silent call CocActionAsync('highlight')
]])
