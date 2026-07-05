inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  options,
  ...
}:
{
  imports = [ wlib.wrapperModules.neovim ];

  config.settings.config_directory = ./.;
  config.settings.aliases = [ "vim" ];

  config.specs.start = with pkgs.vimPlugins; [
    catppuccin-nvim
    lze
  ];

  config.specs.lazy = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      autolist-nvim
      blink-cmp
      bufferline-nvim
      conform-nvim
      diffview-nvim
      flash-nvim
      friendly-snippets
      fzf-lua
      gitsigns-nvim
      grug-far-nvim
      guess-indent-nvim
      img-clip-nvim
      mini-nvim
      noice-nvim
      nvim-lint
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-ufo
      persistence-nvim
      rainbow-delimiters-nvim
      snacks-nvim
      todo-comments-nvim
      trouble-nvim
      vim-wakatime
      which-key-nvim
      yazi-nvim
    ];
  };

  config.runtimePkgs = with pkgs; [
    coreutils
    fd
    fzf
    git
    tree-sitter
    pngpaste
    wakatime-cli
    delta
    lazygit
    nushell
  ];
}