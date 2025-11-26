return {
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
        "mrcjkb/rustaceanvim",
    },
    {
        "cordx56/rustowl",
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
    {
        'startup-nvim/startup.nvim',
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
        config = function()
            require("startup").setup()
        end,
    },
}
