-- lua/vim_config.lua
local o = vim.opt

vim.g.mapleader = ' '       -- Space is the leader key
o.expandtab = true          -- Spaces, not tabs
o.shiftwidth = 2            -- 2 spaces per indent level
o.number = true             -- Absolute number on the cursor line
o.relativenumber = true     -- Enables relative numbers elsewhere for fast jumps
o.ignorecase = true         -- Search in case-insensitive by default
o.smartcase = true          -- Case-sensitive only if typed in capital
o.clipboard = 'unnamedplus' -- Share the system clipboard
o.scrolloff = 16            -- Keep cursor away from the screen edge
o.undofile = true           -- Persistent undo across sessions
