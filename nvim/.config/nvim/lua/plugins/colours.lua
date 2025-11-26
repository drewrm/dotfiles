return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function ()
            vim.cmd.colorscheme("tokyonight-night")
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
    },
}
