-- Configuración principal de lazy.nvim y módulos de LazyVim

-- Node.js y Python (pyenv) para proveedores de Neovim
vim.g.node_host_prog = vim.g.node_host_prog or vim.fn.exepath("node") or "/usr/bin/node"

local pyenv_python = vim.fn.expand("~/.pyenv/shims/python3")
if vim.fn.executable(pyenv_python) == 1 then
  vim.g.python3_host_prog = pyenv_python
elseif vim.fn.executable("/usr/bin/python3") == 1 then
  vim.g.python3_host_prog = "/usr/bin/python3"
end

-- Ortografía desactivada por defecto para no subrayar texto/código en español
-- (Puedes activarla manualmente cuando quieras con: Espacio + u + s)
vim.opt.spell = false
vim.opt.spelllang = { "es", "en" }

-- Bootstrap de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- Base de LazyVim
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Módulos de Editor y Navegación
    { import = "lazyvim.plugins.extras.editor.harpoon2" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.mini-diff" },

    -- Debugging (DAP)
    { import = "lazyvim.plugins.extras.dap.core" },

    -- Soporte de Lenguajes (Python, TypeScript/JS, JSON, Markdown)
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.typescript.biome" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },

    -- Autocompletado y Utilidades de Código
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.coding.blink" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

    -- Tus plugins personalizados (carpeta lua/plugins/)
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "gentleman-kanagawa-blur", "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
