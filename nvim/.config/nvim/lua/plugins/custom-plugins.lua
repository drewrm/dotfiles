local lsps = {
    "codebook",
    "rust_analyzer",
    "vimls",
    "csharp_ls",
    "jdtls",
    "cobol_ls",
}

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
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = lsps
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        lazy = false,
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
        build = ":TSUpdate",
        config = function ()
            require 'nvim-treesitter.configs'.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust", "java", "c_sharp" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            for index, lsp in ipairs(lsps) do
                vim.lsp.enable(lsp)
                vim.lsp.config(lsp, {
                    capabilities = capabilities
                })
            end
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
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
        config = function ()
            local cmp = require 'cmp'
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },


                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),

                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                }, {
                    { name = 'buffer' },
                })
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end
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
                    hidden = true,
                },
                extensions = {
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
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
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
            require("startup").setup()
        end,
    },
}
