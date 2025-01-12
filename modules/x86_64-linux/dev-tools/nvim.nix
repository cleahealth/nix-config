{ inputs, ... }:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];

  # nvim config for development environment
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    opts = {
      number = true; # show line numbers
    };
    plugins = {
      bufferline.enable = true;
      comment.enable = true;
      gitsigns.enable = true;
      lualine.enable = true;
      lsp.enable = true;
      notify.enable = true;
      nvim-autopairs.enable = true;
      nvim-tree.enable = true;
      todo-comments.enable = true;
      treesitter.enable = true;
      trouble.enable = true;
      web-devicons.enable = true;
    };
    viAlias = true;
    vimAlias = true;
  };
}
