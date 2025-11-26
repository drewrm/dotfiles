return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "andrew-george/telescope-themes",
            "nvim-telescope/telescope-project.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { ".git/" },
                    hidden = true,
                },
                extensions = {
                    project = {
                        base_dirs = {
                            "~/dotfiles",
                            "~/Projects",
                            "~/repos/",
                        },
                        hidden_files = true,
                        ignore_missing_dirs = true,
                    },
                    file_browser = {
                        hidden = true,
                    },
                    fzf = {
                        fuzzy = true,                    -- enable fuzzy matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- ignore case unless uppercase query
                    },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("project")
            telescope.load_extension("themes")
        end,
        keys = {
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files({
                        hidden = true,       -- include dotfiles
                        no_ignore = true,    -- ignore .gitignore rules
                    })
                end,
                desc = "Find files"
            },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>",   desc = "Recent files" },
            { "<leader>fc", "<cmd>Telescope commands<cr>",   desc = "Commands" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>",desc = "Diagnostics" },
            { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
            { "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions" },
            { "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP Implementations" },
            { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
            { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "Git commits" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>",   desc = "Git status" },
            { "<leader>fp", "<cmd>Telescope project<cr>",  desc = "View Projects" },
        },
    },
}
