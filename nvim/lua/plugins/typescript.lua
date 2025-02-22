return {
  -- npm install -g typescript typescript-language-server
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "typescript", "typescriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(client)
        local lsp = require('lspconfig')
        if lsp.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
          client.stop()
          return
        end
      end,
    },
  },
}
