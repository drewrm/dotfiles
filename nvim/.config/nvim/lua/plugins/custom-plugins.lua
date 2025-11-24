return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
    },
    {
        "lambdalisue/vim-fern",
        dependencies = {
            "lambdalisue/vim-fern-git-status",
            "lambdalisue/vim-nerdfont",
            "lambdalisue/vim-fern-hijack",
            "lambdalisue/vim-fern-renderer-nerdfont",
        },
    },
    {
        "catgoose/nvim-colorizer.lua",
    },
    {
        "mrcjkb/rustaceanvim",
    },
    {
        "cordx57/rustowl",
    },
    {
        "rust-lang/rust.vim",
    },
    {
        "mason-org/mason.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
    },
    {
        "onsails/lspkind.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 
                "nvim-telescope/telescope-fzf-native.nvim",
                build = make,
            },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { ".git/" },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- enable fuzzy matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- ignore case unless uppercase query
                    },
                },
            })
            telescope.load_extension("fzf")
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
        },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps"
            },
        },
    },
}
