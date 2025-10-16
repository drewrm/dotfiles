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

call vundle#end()
filetype plugin indent on
colorscheme tokyonight-night

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
