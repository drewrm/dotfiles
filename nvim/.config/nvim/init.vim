set nocompatible
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'folke/tokyonight.nvim'
Plugin 'Github/copilot.vim'
Plugin 'lambdalisue/vim-fern'
Plugin 'lambdalisue/vim-fern-git-status'
Plugin 'lambdalisue/vim-nerdfont'
Plugin 'lambdalisue/vim-fern-hijack'
Plugin 'lambdalisue/vim-fern-renderer-nerdfont'
Plugin 'catgoose/nvim-colorizer.lua'

call vundle#end()

filetype plugin indent on
colorscheme tokyonight-night

lua <<EOF
    require 'colorizer'.setup({
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
    })
EOF

autocmd BufReadPost * lua require 'colorizer'.attach_to_buffer(0)
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden = 1

function! s:init_fern() abort
  " Define NERDTree like mappings
  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  nmap <buffer> ma <Plug>(fern-action-new-path)
  nmap <buffer> P gg
  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  nmap <buffer> cd <Plug>(fern-action-cd)
  nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
  nmap <buffer> I <Plug>(fern-action-hidden:toggle)
  nmap <buffer> q :<C-u>quit<CR>	

  nmap <buffer><expr>
      \ <Plug>(fern-my-expand-or-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-collapse)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

  nmap <buffer><nowait> l <Plug>(fern-my-expand-or-collapse)

endfunction


augroup fern-custom
  autocmd!
  autocmd FileType fern call s:init_fern()
augroup END

nmap <silent> <leader>f :Fern . -drawer -toggle<CR>

set shiftwidth=4
set expandtab
