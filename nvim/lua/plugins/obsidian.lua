-- ==============================================================================
-- OBSIDIAN.NVIM - GESTIÓN DE NOTAS Y SEGUNDO CEREBRO EN NEOVIM
-- ==============================================================================
-- Ruta predeterminada de tu repositorio privado de notas: ~/Proyectos/notas
-- (Puedes sobreescribirla con la variable de entorno OBSIDIAN_VAULT si deseas)

local vault_path = vim.env.OBSIDIAN_VAULT or vim.fn.expand("~/Proyectos/notas")

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  enabled = function()
    return not vim.g.disable_obsidian
  end,
  init = function()
    -- Crear automáticamente la estructura base de la bóveda si aún no se ha clonado el repo
    local dirs = {
      vault_path,
      vault_path .. "/templates",
      vault_path .. "/diarias",
      vault_path .. "/proyectos",
    }
    for _, dir in ipairs(dirs) do
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
      end
    end

    -- Crear una plantilla base si no existe ninguna todavía
    local default_tpl = vault_path .. "/templates/nota-tecnica.md"
    if vim.fn.filereadable(default_tpl) == 0 then
      local f = io.open(default_tpl, "w")
      if f then
        f:write(table.concat({
          "# {{title}}",
          "",
          "- **Fecha:** {{date}} {{time}}",
          "- **Tags:** #tecnico",
          "",
          "## Resumen",
          "",
          "",
          "## Comandos / Código",
          "```bash",
          "",
          "```",
          "",
          "## Notas Relacionadas",
          "- ",
        }, "\n"))
        f:close()
      end
    end
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "NotasPersonales",
        path = vault_path,
      },
    },

    -- Cómo se nombran los archivos .md al crear una nota con :Obsidian new Titulo
    -- Ejemplo: "Comandos de Docker" -> "comandos-de-docker.md"
    note_id_func = function(title)
      if title ~= nil and title ~= "" then
        return title
          :gsub(" ", "-")
          :gsub("[^A-Za-z0-9-áéíóúÁÉÍÓÚñÑ]", "")
          :lower()
      else
        return tostring(os.date("%Y-%m-%d-%H%M"))
      end
    end,

    -- Configuración de Notas Diarias (Bitácora de trabajo)
    daily_notes = {
      folder = "diarias",
      date_format = "%Y-%m-%d",
      alias_format = "%d/%m/%Y",
      default_tags = { "diario" },
    },

    picker = {
      name = "snacks.picker",
    },

    callbacks = {
      enter_note = function(note)
        if not note then
          return
        end
        -- Saltar al archivo enlazado bajo el cursor [[otra-nota]] con 'gf'
        vim.keymap.set("n", "gf", function()
          return require("obsidian").util.gf_passthrough()
        end, { buffer = note.bufnr, expr = true, desc = "Obsidian: Ir al enlace [[nota]]" })

        -- Marcar / desmarcar casilla de tarea [ ] <-> [x]
        vim.keymap.set("n", "<leader>ch", function()
          return require("obsidian").util.toggle_checkbox()
        end, { buffer = note.bufnr, desc = "Obsidian: Marcar/Desmarcar tarea" })

        -- Enter inteligente: sigue enlaces [[nota]] o marca casillas [ ]
        vim.keymap.set("n", "<cr>", function()
          return require("obsidian").util.smart_action()
        end, { buffer = note.bufnr, expr = true, desc = "Obsidian: Acción inteligente (Enter)" })
      end,
    },

    -- Configuración de plantillas (carpeta ~/Proyectos/notas/templates)
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
  },
}
