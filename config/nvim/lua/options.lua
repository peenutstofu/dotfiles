vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false

-- auto scroll when reaching top/end
vim.opt.scrolloff = 8

vim.opt.clipboard = "unnamedplus"

-- enable mouse
vim.opt.mouse = "a"

vim.g.wildignorecase = true

vim.opt.signcolumn = "yes:1"

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4

if vim.fn.has('win32') == 1 then
  if vim.fn.executable('pwsh') == 1 then
    vim.o.shell = 'pwsh'
  else
    vim.o.shell = 'powershell'
  end
  vim.o.shellcmdflag = '-NoLogo -c'
  vim.o.shellquote = '"'
  vim.o.shellxquote = ''
elseif vim.fn.has("linux") == 1 then
  if vim.fn.system('which zsh | grep not') ~= '' then
    vim.o.shell = 'zsh'
  else
    vim.o.shell = 'bash'
  end
end



-- use space as leader key
vim.g.mapleader = " "
