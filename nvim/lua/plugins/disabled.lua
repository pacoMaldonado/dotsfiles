-- ==============================================================================
-- CONTROL DE PLUGINS ACTIVOS / DESACTIVADOS
-- ==============================================================================
-- Para activar cualquiera de estos plugins, cambia 'enabled = false' a 'enabled = true'

return {
  {
    -- Barra superior de pestañas (desactivada para usar Incline + Harpoon)
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    -- OpenCode AI: Desactivado por defecto. Cambia a 'enabled = true' cuando quieras usarlo.
    "NickvanDyke/opencode.nvim",
    enabled = false,
  },
  {
    -- Precognition: Muestra pistas de movimientos de Vim. Cambia a 'enabled = true' para practicar.
    "tris203/precognition.nvim",
    enabled = false,
  },
  {
    -- Smear Cursor: Estela de cursor dentro de Neovim (desactivado porque ya tenemos el shader en Ghostty)
    "sphamba/smear-cursor.nvim",
    enabled = false,
  },
  {
    -- Claude Code: Activo por defecto
    "coder/claudecode.nvim",
    enabled = true,
  },
}
