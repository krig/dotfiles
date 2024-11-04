return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
          events = { "BufWritePost", "BufReadPost", "InsertLeave" },
          linters_by_ft = {
            python = { "ruff" },
            sql = { "sqlfluff" },
          },
          linters = {
            sqlfluff = {
              args = {
                'lint', '--format=json', '--dialect=sqlite',
              },
            },
          },
        },
        config = function(_, opts)
          local M = {}

          local lint = require "lint"
          for name, linter in pairs(opts.linters) do
            if type(linter) == "table" and type(lint.linters[name]) == "table" then
              lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
              if type(linter.prepend_args) == "table" then
                lint.linters[name].args = lint.linters[name].args or {}
                vim.list_extend(lint.linters[name].args, linter.prepend_args)
              end
            else
              lint.linters[name] = linter
            end
          end
          lint.linters_by_ft = opts.linters_by_ft

          function M.debounce(ms, fn)
            local timer = vim.uv.new_timer()
            return function(...)
              local argv = { ... }
              timer:start(ms, 0, function()
                timer:stop()
                vim.schedule_wrap(fn)(unpack(argv))
              end)
            end
          end

          function M.lint()
            -- Use nvim-lint's logic first:
            -- * checks if linters exist for the full filetype first
            -- * otherwise will split filetype by "." and add all those linters
            -- * this differs from conform.nvim which only uses the first filetype that has a formatter
            local names = lint._resolve_linter_by_ft(vim.bo.filetype)

            -- Create a copy of the names table to avoid modifying the original.
            names = vim.list_extend({}, names)

            -- Add fallback linters.
            if #names == 0 then
              vim.list_extend(names, lint.linters_by_ft["_"] or {})
            end

            -- Add global linters.
            vim.list_extend(names, lint.linters_by_ft["*"] or {})

            -- Filter out linters that don't exist or don't match the condition.
            local ctx = { filename = vim.api.nvim_buf_get_name(0) }
            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
            names = vim.tbl_filter(function(name)
              local linter = lint.linters[name]
              if not linter then
                vim.print("Linter not found: " .. name)
              end
              return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
            end, names)

            -- Run linters.
            if #names > 0 then
              lint.try_lint(names)
            end
          end

          vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = M.debounce(100, M.lint),
          })
        end,
      },
      {
        "rshkarin/mason-nvim-lint",
        opts = {
          ensure_installed = { "sqlfluff", "bacon", "ruff" },
        },
      },
    },
    keys = {
      { "<leader>n", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "<leader>ll", "<cmd>LspLog<cr>", desc = "Lsp Log" },
      { "<leader>ls", "<cmd>LspStop<cr>", desc = "Lsp Stop" },
      { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Lsp Restart" },
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
      { "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    },
    opts = function()
      return {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        },
        inlay_hints = {
          enabled = false,
        },
        codelens = {
          enabled = false,
        },
        document_highlight = {
          enabled = false,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          },
          denols = {
            root_dir = require('lspconfig').util.root_pattern("deno.json", "deno.jsonc"),
          },
          ts_ls = {
            root_dir = require('lspconfig').util.root_pattern("package.json"),
            single_file_support = false,
          },
        },
        setup = {},
      }
    end,
    config = function(_, opts)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup {
          ensure_installed = vim.tbl_deep_extend("force", ensure_installed, {}),
          handlers = { setup },
        }
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "prettierd",
        "pyright",
        "ruff",
        "ruff-lsp",
        "deno",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger {
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
