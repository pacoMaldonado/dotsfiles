-- ==============================================================================
-- INTEGRACIÓN DE CLIs DE IA EN NEOVIM: ANTIGRAVITY (agy) Y AWS KIRO (kiro-cli)
-- ==============================================================================
-- Reemplaza el antiguo plugin roto de gemini-cli por integración directa con:
--   1. Antigravity CLI (agy)    -> Espacio + a + g
--   2. AWS Kiro CLI (kiro-cli)  -> Espacio + a + k
--   (Junto con Claude Code en claude-code.lua -> Espacio + a + c)

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>ag",
      function()
        Snacks.terminal.toggle("agy", {
          cwd = LazyVim.root(),
          win = {
            position = "left",
            width = 0.35,
          },
        })
      end,
      desc = "Toggle Antigravity CLI (agy)",
      mode = { "n", "t" },
    },
    {
      "<leader>ak",
      function()
        Snacks.terminal.toggle("kiro-cli", {
          cwd = LazyVim.root(),
          win = {
            position = "left",
            width = 0.35,
          },
        })
      end,
      desc = "Toggle AWS Kiro CLI (kiro-cli)",
      mode = { "n", "t" },
    },
  },
}
