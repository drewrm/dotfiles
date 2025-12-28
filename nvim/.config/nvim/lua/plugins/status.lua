return {
    {
        "itchyny/lightline.vim",
        config = function ()
            vim.g.lightline = {
                colorscheme = 'deus',
                active = {
                    left = { {'mode', 'paste'}, {'readonly', 'filename', 'modified'} },
                    right = { {'lineinfo'}, {'percent'} }
                },
            }
        end
    }
}
