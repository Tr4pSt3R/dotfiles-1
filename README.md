# Plugin Installation Instructions

Plug-ins in the provide .vimrc file can be installed with
the recommended vim plug-in manager, Neobundle.

See here for more installation instructions: https://github.com/Shougo/dein.vim

## Requirements

- Vim 7.4 or above or NeoVim.
- "xcopy" command in $PATH (Windows)
- "git" command in $PATH (if you want to install github or vim.org plugins)

## Quick start

**Note**: You must define the installation directory before to use dein.  It
depends on your usage.

For example, `~/.vim/bundles` or `~/.cache/dein` or `~/.local/share/dein`.
dein.vim has not define the default installation directory.
You must **not** set the installation directory under `~/.vim/plugin` or
`~/.config/nvim/plugin`.

### Unix/Linux or Mac OS X

1. Run below script.

```sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein
```

2. Edit your .vimrc like this.

```vim
if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')

 call dein#add('~/.cache/dein')
 call dein#add('Shougo/deoplete.nvim')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif

 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
syntax enable
```

3. Open vim and install dein

```vim
:call dein#install()
```

## Install Git Completion
To use these routines:

   1) Copy this file(git-completition) to somewhere (e.g. ~/.git-completion.bash).
   2) Add the following line to your .bashrc/.zshrc:
       source ~/.git-completion.bash
