local function ruby_lsp_settings()
  local lsp = vim.g.lazyvim_ruby_lsp or "ruby_lsp"
  local formatter = vim.g.lazyvim_ruby_formatter or "rubocop"
  local servers = {}

  if lsp == "ruby_lsp" then table.insert(servers, "ruby_lsp") end
  if lsp == "solargraph" then table.insert(servers, "solargraph") end
  if formatter == "rubocop" and lsp ~= "solargraph" then table.insert(servers, "rubocop") end
  if formatter == "standardrb" then table.insert(servers, "standardrb") end

  return servers, formatter
end

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local servers = ruby_lsp_settings()
      opts.servers = require("astrocore").list_insert_unique(opts.servers or {}, servers)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "ruby-lsp",
        "solargraph",
        "rubocop",
        "standardrb",
        "erb-formatter",
        "erb-lint",
      })
      opts.run_on_start = true
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, { "ruby" })
    end,
  },
  {
    "suketa/nvim-dap-ruby",
    config = function() require("dap-ruby").setup() end,
  },
  { "olimorris/neotest-rspec" },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "suketa/nvim-dap-ruby",
        config = function() require("dap-ruby").setup() end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local _, formatter = ruby_lsp_settings()
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        ruby = { formatter },
        eruby = { "erb_format" },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "olimorris/neotest-rspec" },
    opts = function(_, opts)
      opts.adapters = require("astrocore").list_insert_unique(opts.adapters or {}, {
        ["neotest-rspec"] = {},
      })
    end,
  },
}
