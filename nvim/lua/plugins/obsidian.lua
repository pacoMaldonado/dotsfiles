return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  enabled = function()
    return not vim.g.disable_obsidian
  end,
  init = function()
    -- Asegurar que la carpeta de notas y templates exista siempre tras formatear la PC
    local vault_dir = vim.fn.expand("~/.config/obsidian/templates")
    if vim.fn.isdirectory(vault_dir) == 0 then
      vim.fn.mkdir(vault_dir, "p")
    end
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "Notes",
        path = vim.fn.expand("~/.config/obsidian"),
      },
    },
    picker = {
      name = "snacks.picker",
    },
    callbacks = {
      enter_note = function(note)
        if not note then
          return
        end
        vim.keymap.set("n", "gf", function()
          return require("obsidian").util.gf_passthrough()
        end, { buffer = note.bufnr, expr = true, desc = "Obsidian follow link" })

        vim.keymap.set("n", "<leader>ch", function()
          return require("obsidian").util.toggle_checkbox()
        end, { buffer = note.bufnr, desc = "Toggle checkbox" })

        vim.keymap.set("n", "<cr>", function()
          return require("obsidian").util.smart_action()
        end, { buffer = note.bufnr, expr = true, desc = "Obsidian smart action" })
      end,
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      gtime_format = "%H:%M",
      tags = "",
    },
  },
}
