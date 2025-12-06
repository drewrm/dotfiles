return {
    {
        "lambdalisue/vim-fern",
        dependencies = {
            "lambdalisue/vim-fern-git-status",
            "lambdalisue/vim-nerdfont",
            "lambdalisue/vim-fern-hijack",
            "lambdalisue/vim-fern-renderer-nerdfont",
        },
        lazy = false,
        config = function()
            vim.g["fern#renderer"] = "nerdfont"
            vim.g["fern#default_hidden"] = 1
            vim.g["fern#git_status#enable"] = 1

            local function init_fern()
                -- NERDTree-like mappings
                vim.keymap.set("n", "d", "<Plug>(fern-action-remove)", { buffer = true })
                vim.keymap.set("n", "o", "<Plug>(fern-action-open:edit)", { buffer = true })
                vim.keymap.set("n", "go", "<Plug>(fern-action-open:edit)<C-w>p", { buffer = true })
                vim.keymap.set("n", "t", "<Plug>(fern-action-open:tabedit)", { buffer = true })
                vim.keymap.set("n", "T", "<Plug>(fern-action-open:tabedit)gT", { buffer = true })
                vim.keymap.set("n", "i", "<Plug>(fern-action-open:split)", { buffer = true })
                vim.keymap.set("n", "gi", "<Plug>(fern-action-open:split)<C-w>p", { buffer = true })
                vim.keymap.set("n", "s", "<Plug>(fern-action-open:vsplit)", { buffer = true })
                vim.keymap.set("n", "gs", "<Plug>(fern-action-open:vsplit)<C-w>p", { buffer = true })
                vim.keymap.set("n", "ma", "<Plug>(fern-action-new-path)", { buffer = true })
                vim.keymap.set("n", "P", "gg", { buffer = true })
                vim.keymap.set("n", "C", "<Plug>(fern-action-enter)", { buffer = true })
                vim.keymap.set("n", "u", "<Plug>(fern-action-leave)", { buffer = true })
                vim.keymap.set("n", "r", "<Plug>(fern-action-reload)", { buffer = true })
                vim.keymap.set("n", "R", "gg<Plug>(fern-action-reload)<C-o>", { buffer = true })
                vim.keymap.set("n", "cd", "<Plug>(fern-action-cd)", { buffer = true })
                vim.keymap.set("n", "CD", "gg<Plug>(fern-action-cd)<C-o>", { buffer = true })
                vim.keymap.set("n", "I", "<Plug>(fern-action-hidden:toggle)", { buffer = true })
                vim.keymap.set("n", "q", ":<C-u>quit<CR>", { buffer = true })

                -- expr mapping: expand or collapse
                vim.keymap.set("n", "<Plug>(fern-my-expand-or-collapse)", function()
                  return vim.fn["fern#smart#leaf"](
                    "<Plug>(fern-action-collapse)",
                    "<Plug>(fern-action-expand)",
                    "<Plug>(fern-action-collapse)"
                  )
                end, { buffer = true, expr = true })

                -- nowait mapping
                vim.keymap.set("n", "l", "<Plug>(fern-my-expand-or-collapse)", { buffer = true, nowait = true })
            end

            -- autocmd group
            local fern_group = vim.api.nvim_create_augroup("fern-custom", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = fern_group,
                pattern = "fern",
                callback = init_fern,
            }) 
        end,
        keys = {
            {
            "<leader>d",
            "<cmd>Fern . -reveal=% -drawer -toggle<cr>",
            desc = "Toggle File Explorer",
            },
        },
    },
    {
        "mrcjkb/rustaceanvim",
        lazy = false,
    },
    {
        "cordx56/rustowl",
        lazy = false,
    },
    {
        "rust-lang/rust.vim",
    },
    {
        "mfussenegger/nvim-dap",
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
