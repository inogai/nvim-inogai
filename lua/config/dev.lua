-- Dev configuration for dynamically loading local plugins
-- Prepend to rtp to override nix-managed plugins

-- Example: Load moegi.nvim from local workspace
-- Live-reload is particularly useful for colorscheme development
vim.opt.runtimepath:prepend('/Users/inogai/Workspaces/moegi.nvim')
