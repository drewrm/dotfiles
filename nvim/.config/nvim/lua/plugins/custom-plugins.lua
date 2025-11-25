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
        event = "VeryLazy",
        opts = {
            lazy_load = true,
            filetypes = { '*' },
            user_default_options = {
                RGB = true; -- #RGB hex codes
                RRGGBB = true; -- #RRGGBB hex codes
                RRGGBBAA = true; -- #RRGGBBAA hex codes
                rgb_fn = true; -- CSS rgb() and rgba() functions
                hsl_fn = true; -- CSS hsl() and hsla() functions
                css = true; -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true; -- Enable all CSS *functions*: rgb_fn, hsl_fn
            },
        },
    },
    {
        "mrcjkb/rustaceanvim",
    },
    {
        "cordx56/rustowl",
    },
    {
        "rust-lang/rust.vim",
    },
    {
        "mason-org/mason-lspconfig.nvim",
         config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "rust_analyzer",
                    "csharp_ls",
                    "vimls",
                    "jdtls",
                }
            })
         end,
    },
    {
        "mason-org/mason.nvim",
        config = function()
           require("mason").setup()
        end,
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
          vim.lsp.enable('codebook')
          vim.lsp.enable('rust_analyzer')
          vim.lsp.enable('vimls')
          vim.lsp.enable('csharp_ls')
          vim.lsp.enable('jdtls')
        end,
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
    {
        'startup-nvim/startup.nvim',
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
        config = function()
            require "startup".setup()
        end,
    },
}
