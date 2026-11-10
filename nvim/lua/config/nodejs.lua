-- Node.js configuration for Neovim
-- Prioritizes fnm (Fast Node Manager) and system Node.js (v18+)

local M = {}

local function get_system_node()
  local system_paths = {
    vim.fn.expand("~/.local/share/fnm/aliases/default/bin/node"), -- fnm default alias
    vim.fn.expand("~/.local/share/fnm/node-versions/*/installation/bin/node"), -- fnm installed versions
    vim.fn.expand("~/.volta/bin/node"),
    vim.fn.expand("~/.nvm/versions/node/*/bin/node"),
    "/usr/local/bin/node",
    "/usr/bin/node",
  }

  for _, path in ipairs(system_paths) do
    if path:match("%*") then
      local expanded = vim.fn.glob(path, false, true)
      if #expanded > 0 then
        table.sort(expanded, function(a, b)
          return a > b
        end)
        path = expanded[1]
      else
        goto continue
      end
    end

    if vim.fn.executable(path) == 1 then
      return path
    end

    ::continue::
  end

  return vim.fn.exepath("node")
end

local function setup_nodejs()
  local node_path = get_system_node()

  if node_path ~= "" then
    local version_output = vim.fn.system(node_path .. " --version 2>/dev/null")
    if vim.v.shell_error == 0 then
      local version = version_output
        :gsub("\r", "")
        :gsub("\n", "")
        :gsub("\27%[[%d;]*%a", "")
        :gsub("^v", "")
        :match("(%d+%.%d+%.%d+)")

      if version then
        local major_version = tonumber(version:match("^(%d+)"))
        if major_version and major_version >= 18 then
          vim.g.node_host_prog = node_path
          local npm_path = vim.fn.exepath("npm")
          if npm_path ~= "" then
            vim.g.npm_host_prog = npm_path
          end
          return true, version
        else
          vim.notify(
            "⚠️ Node.js v" .. version .. " es antiguo. Instala LTS con: fnm install --lts",
            vim.log.levels.WARN
          )
          vim.g.node_host_prog = node_path
          return true, version
        end
      end
    end
  end

  return false, nil
end

function M.setup(opts)
  opts = opts or {}
  local success = setup_nodejs()
  return success
end

function M.info()
  if not vim.g.node_host_prog then
    print("Node.js: No configurado (ejecuta 'fnm install --lts' en terminal)")
    return
  end

  local version_output = vim.fn.system(vim.g.node_host_prog .. " --version 2>/dev/null")
  local version = version_output:gsub("\n", ""):gsub("v", "")
  print("Node.js para Neovim: " .. vim.g.node_host_prog .. " (v" .. version .. ")")

  if vim.g.node_host_prog:match("fnm") then
    print("Origen: fnm (Fast Node Manager)")
  else
    print("Origen: Sistema")
  end
end

vim.api.nvim_create_user_command("NodeRefresh", function()
  M.setup({ silent = false })
  M.info()
end, { desc = "Recargar configuración de Node.js" })

vim.api.nvim_create_user_command("NodeInfo", function()
  M.info()
end, { desc = "Mostrar información de Node.js en Neovim" })

return M
