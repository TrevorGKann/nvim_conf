--- change default behavior of actions ---
vim.keymap.set({"n","v"}, "d", "\"_d", {desc = "delete to void instead of yank-delete"})

--- navigate between panes ---
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "move to pane on left"})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "move to pane below"})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "move to pane above"})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "move to pane on right"})

