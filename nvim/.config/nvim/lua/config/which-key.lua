local wk = require("which-key")

wk.register({
  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
    o = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
  },
  g = {
    name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Branches" },
    c = { "<cmd>Telescope git_commits<cr>", "Commits" },
    s = { "<cmd>Telescope git_status<cr>", "Status" },
  },
  l = {
    name = "LSP",
    d = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
    i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
    t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type definitions" },
  },
}, { prefix = "<leader>?" })

