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
        "mason-org/mason.nvim",
        lazy = false,
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = lsps
            })
            vim.cmd.highlight({ "MasonHighlight", "guifg=#bb9af7", "guibg=#1a1b26" })
            vim.cmd.highlight({ "MasonHighlightBlockBold", "guibg=#bb9af7", "guifg=#1a1b26" })
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
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            vim.lsp.config["lua_ls"] = {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            }

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            for _, lsp in ipairs(lsps) do
                vim.lsp.enable(lsp)
                vim.lsp.config(lsp, {
                    capabilities = capabilities
                })
            end

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                callback = function()
                    vim.diagnostic.open_float(nil, { focus = false })
                end,
            })


            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        dependencies = {
            "copilotlsp-nvim/copilot-lsp",
        },
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = {
            "zbirenbaum/copilot.lua",
        },
        config = function ()
            require("copilot_cmp").setup()
        end
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
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
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
                    { name = 'copilot' },
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
        config = function ()
            require("lspkind").init({
                preset = 'codicons',
                symbol_map = {
                    Copilot = "",
                },
            })
        end
    },
}
