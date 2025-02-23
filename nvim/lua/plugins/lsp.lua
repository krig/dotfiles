return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lsp = require('lspconfig')
      lsp.janet_lsp.setup {}
      lsp.lua_ls.setup {}
      lsp.ols.setup {}
      lsp.denols.setup {
        on_attach = function(client)
          if not lsp.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
            client.stop()
            return
          end
        end,
      }
      -- npm i -g vscode-langservers-extracted
      lsp.eslint.setup {}
      lsp.pyright.setup {
        on_new_config = function()
          if vim.env.VIRTUAL_ENV == nil then
            local venv_marker = {".venv"}
            local venv_root = vim.fs.root(0, venv_marker)
            if venv_root then
              vim.env.VIRTUAL_ENV = venv_root .. "/" .. ".venv"
              vim.env.PATH = venv_root .. "/.venv/bin:" .. vim.env.PATH
            end
          end
        end,
      }
      lsp.rust_analyzer.setup {}
      lsp.superhtml.setup {}
      lsp.zls.setup {}
      lsp.clangd.setup {}

      local keys = {
        { "<leader>cf", vim.lsp.buf.format, desc = "Format buffer" },
        { "<leader>cD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        { "<leader>kk", vim.lsp.buf.hover, desc = "Hover" },
        { "<leader>kh", vim.lsp.buf.signature_help, desc = "Signature Help" },
        { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
        { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
        { "<leader>ld", vim.lsp.buf.definition, desc = "Goto definition (LSP)" },
      }
      for _, key in ipairs(keys) do
        vim.keymap.set("n", key[1], key[2], { desc = key["desc"] })
      end
    end,
  },
}
