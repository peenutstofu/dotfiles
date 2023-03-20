local status, wk = pcall(require, "which-key")
if not status then
  return
end

wk.setup({
  plugins = {
    marks = true,
    registers = true,
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
})

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["<TAB>"] = { ":b#<cr>", "Last buffer" },
  ["\\"] = { "<cmd>:ToggleTermSendCurrentLine<CR>", "Send current line to terminal" },
  [";"] = { "<cmd>:call CocAction('format')<CR>", "Format buffer" },
  ["e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },
  ["W"] = { "<cmd>wa!<CR>", "Save" },
  ["q"] = { "<cmd>qa!<CR>", "Quit" },
  -- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },

  a = {
    name = "Anything",
    a = { "<cmd>Telescope coc code_actions<cr>", "Code Actions" },
    A = { "<cmd>Alpha<cr>", "Alpha" },
    c = { "<cmd>Telescope coc coc<cr>", "Coc" },
    l = { "<cmd>Telescope coc links<cr>", "links" },
    C = { "<cmd>Telescope coc commands<cr>", "Coc commands" },

    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
  },

  b = {
    name = "Buffers",
    ["<TAB>"] = { ":b#<cr>", "Last buffer" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    d = { ":bd<CR>", "Kill buffer" },
    D = { ":bd!<CR>", "Kill buffer discard any changes" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    n = { ":bnext<CR>", "Next tab" },
    l = { ":ls<CR>", "List buffers" },
    p = { ":bprevious<CR>", "Previous tab" },
    P = { ":BufferLinePick<CR>", "Pick Buffer" },
  },

  f = {
    name = "Files",
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    p = { "<cmd>Telescope git_files<cr>", "Find project files" },
    r = { "<cmd>Telescope oldfiles<cr>", "Find recent files" },
    t = { "<cmd>Neotree toggle<cr>", "Explorer" },
    w = { "<Cmd>:Telescope neorg switch_workspace<CR>", "Workspaces" },
  },

  g = {
    name = "Git",
    -- g = { "<cmd>Neogit<CR>", "Neogit" },
    -- g = { "<cmd>LazyGit<cr>", "Lazygit" },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
    -- g = { "<cmd>lua _GITUI_TOGGLE()<cr>", "Gitui" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      name = "Diff",
      c = { "<cmd>DiffviewClose<cr>", "Close" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff" },
      f = {
        "<cmd>DiffviewFileHistory<cr>",
        "Diff current file",
      },
    },
  },

  m = {
    name = "Code",
    [";"] = { "<cmd>:call CocAction('format')<CR>", "Format buffer" },
    A = { "<cmd>Telescope coc diagnostics<cr>", "Diagnostics" },
    a = { "<cmd>Telescope coc code_actions<cr>", "Code Actions" },
    d = { "<cmd>Telescope coc definitions<cr>", "Definitions" },
    D = { "<cmd>Telescope coc declarations<cr>", "Declarations" },
    f = { "<cmd>Telescope coc file_code_actions<cr>", "File Actions" },
    i = { "<cmd>Telescope coc implementations<cr>", "Implementations" },
    l = { "<cmd>Telescope coc line_code_actions<cr>", "Line Actions" },
    r = { "<cmd>Telescope coc references<cr>", "References" },
    s = { "<cmd>Telescope coc document_symbols<cr>", "Symbols" },
    S = { "<cmd>CocList snippets<cr>", "Snippets" },
    t = { "<cmd>Telescope coc type_definitions<cr>", "Definitions" },
    T = { "<cmd>vista!!<cr>", "Show tags" },
    w = { "<cmd>Telescope coc workspace_symbols<cr>", "Diagnostics" },
    W = { "<cmd>Telescope coc workspace_diagnostics<cr>", "Diagnostics" },
  },

  M = {
    name = "Markdown",
    p = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Preview" },
    g = { "<cmd>Glow<cr>", "Preview with Glow" },
    G = { "<cmd>Glow!<cr>", "Close Glow window" },
  },

  p = {
    name = "Projects",
    p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    f = { "<cmd>Telescope git_files<cr>", "Find files" },
  },

  s = {
    name = "Search",
    s = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    S = { "<cmd>lua require('spectre').open()<cr>", "Search & Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search current word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Find in current file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  t = {
    name = "Terminal",
    A = { "<cmd>ToggleTermToggleAll<cr>", "Toggle all" },
    -- i = { "<cmd>lua _IPYTHON_TOGGLE()<cr>", "Ipython" },
    -- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    -- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    -- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=20 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    t = { "<cmd>ToggleTerm direction=tab<cr>", "Tab" },
  },

  T = {
    name = "Toggle",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    l = { "<cmd>:set number!<CR>", "Toggle line numbers" },
    r = { "<cmd>:set relativenumber!<CR>", "Toggle relative line numbers" },
    -- t = { "<cmd>vista!!<cr>", "Show tags" },
  },

  w = {
    name = "Windows",
    s = { "<cmd>:wincmd s<cr>", "Split window" },
    v = { "<cmd>:wincmd v<cr>", "Split window vertically" },
    w = { "<cmd>:wincmd w<cr>", "Switch windows" },
    q = { "<cmd>:wincmd q<cr>", "Quit a window" },
    T = { "<cmd>:wincmd T<cr>", "Break out into a new tab" },
    x = { "<cmd>:wincmd x<cr>", "Swap current with next" },
    ["-"] = { "<cmd>:wincmd -<cr>", "Decrease height" },
    ["+"] = { "<cmd>:wincmd +<cr>", "Increase height" },
    ["<"] = { "<cmd>:wincmd lt<cr>", "Decrease width" },
    [">"] = { "<cmd>:wincmd ><cr>", "Increase width" },
    ["|"] = { "<cmd>:wincmd |<cr>", "Max out the width" },
    ["_"] = { "<cmd>:wincmd _<cr>", "Max out the height" },
    ["="] = { "<cmd>:wincmd =<cr>", "Equally high and wide" },
    h = { "<cmd>:wincmd h<cr>", "Go to the left window" },
    l = { "<cmd>:wincmd l<cr>", "Go to the right window" },
    k = { "<cmd>:wincmd k<cr>", "Go to the up window" },
    j = { "<cmd>:wincmd j<cr>", "Go to the down window" },
    t = { "<cmd>:WindowsToggleAutowidth<cr>", "Toggle auto width" },
    m = { "<cmd>:WindowsMaximize<cr>", "Maximize" },
  },
  x = {
    name = "Text",
    s = {
      name = "Sort",
      a = { "<cmd>:sort<cr>", "Sort Ascending" },
      d = { "<cmd>:sort!<cr>", "Sort Descending" },
      u = { "<cmd>:sort u<cr>", "Sort Unique" },
      n = { "<cmd>:sort n<cr>", "Sort Numerically" },
    },
  },
}

wk.register(mappings, opts)
