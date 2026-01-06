---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.servers = require("astrocore").list_insert_unique(opts.servers or {}, { "terraformls" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "terraform-ls",
        "tflint",
      })
      opts.run_on_start = true
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "terraform",
        "hcl",
      })
    end,
  },
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    ft = { "terraform", "hcl" },
    config = function()
      require("astrocore").on_load("telescope.nvim", function()
        require("telescope").load_extension("terraform_doc")
      end)
    end,
  },
  {
    "cappyzawa/telescope-terraform.nvim",
    ft = { "terraform", "hcl" },
    config = function()
      require("astrocore").on_load("telescope.nvim", function()
        require("telescope").load_extension("terraform")
      end)
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = require("astrocore").list_insert_unique(opts.sources or {}, {
        null_ls.builtins.formatting.packer,
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.diagnostics.terraform_validate,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        terraform = { "terraform_validate" },
        tf = { "terraform_validate" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        hcl = { "packer_fmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
    },
  },
}
