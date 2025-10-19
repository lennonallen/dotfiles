# vim.nix - NixOS system configuration
# Import this in configuration.nix with: imports = [ ./vim.nix ];

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ 
          # File navigation
          nerdtree
          fzf-vim
          
          # Git integration
          vim-fugitive
          vim-gitgutter
          
          # Status line
          vim-airline
          vim-airline-themes
          
          # Syntax & highlighting
          vim-nix
          vim-polyglot
          
          # Color scheme
          dracula-vim
          
          # Editing enhancements
          vim-commentary
          vim-surround
          auto-pairs
        ];
      };
      vimrcConfig.customRC = ''
        " Basic settings
        set number
        set relativenumber
        set expandtab
        set tabstop=2
        set shiftwidth=2
        set ignorecase
        set smartcase
        set mouse=a
        
        " Color scheme
        colorscheme dracula
        set background=dark
        
        " Better splitting
        set splitbelow
        set splitright
        
        " Highlight current line
        set cursorline
        
        " Enable syntax highlighting
        syntax on
        filetype plugin indent on
        
        " NERDTree settings
        map <C-n> :NERDTreeToggle<CR>
        let NERDTreeShowHidden=1
        
        " FZF shortcuts
        map <C-p> :Files<CR>
        map <C-f> :Rg<CR>
        
        " Quick save
        nnoremap <leader>w :w<CR>
        
        " Split navigation
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l
        
        " Clear search highlighting
        nnoremap <leader><space> :nohlsearch<CR>
        
        " Airline configuration
        let g:airline_theme='dracula'
        let g:airline_powerline_fonts=1
      '';
    })
    
    # Additional tools for fzf functionality
    fzf
    ripgrep
  ];
}
