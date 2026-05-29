return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        --config = function ()
        --    vim.cmd.colorscheme("tokyonight-night")
        --end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        config = function ()
            vim.cmd.colorscheme("kanagawa-wave")
        end,
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
        config = function()
            vim.api.nvim_create_autocmd("BufReadPost", {
                pattern = "*",
                callback = function()
                    require("colorizer").attach_to_buffer(0)
                end
            })
        end,
    },
}
