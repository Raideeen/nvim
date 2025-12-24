-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
vim.cmd("packadd! nohlsearch")

-- [[ Set up variable for nvim leader key ]]
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Set up options ]]
require("config.options")

-- [[ Setup autocommands ]]
require("config.autocommands")

-- [[ Set up keymaps ]]
require("config.keymaps")

-- [[ Configure and install plugins ]]
require("config.lazy")
