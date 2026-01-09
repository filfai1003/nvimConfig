-- Simple "go to" helpers using LSP + Telescope/quickfix

local M = {}

local function has_telescope()
  local ok = pcall(require, "telescope.builtin")
  return ok
end

local function bit_and(a, b)
  local ok_bit, bitlib = pcall(require, "bit")
  if ok_bit and bitlib and bitlib.band then
    return bitlib.band(a, b)
  end
  if _G.bit and _G.bit.band then
    return _G.bit.band(a, b)
  end
  if _G.bit32 and _G.bit32.band then
    return _G.bit32.band(a, b)
  end
  -- Fallback: naive (works only for small numbers)
  local res, bitval = 0, 1
  local x, y = a, b
  while x > 0 or y > 0 do
    local xb = x % 2
    local yb = y % 2
    if xb == 1 and yb == 1 then
      res = res + bitval
    end
    bitval = bitval * 2
    x = math.floor(x / 2)
    y = math.floor(y / 2)
  end
  return res
end

-- Go to definition: prefer Telescope if available
function M.definition()
  if has_telescope() then
    require("telescope.builtin").lsp_definitions({})
  else
    vim.lsp.buf.definition()
  end
end

-- Internal: show locations via Telescope or quickfix
local function show_locations(locations, title)
  if has_telescope() then
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local make_entry = require("telescope.make_entry")

    pickers.new({}, {
      prompt_title = title,
      finder = finders.new_table({
        results = locations,
        entry_maker = make_entry.gen_from_lsp_locations({}),
      }),
      previewer = conf.qflist_previewer({}),
      sorter = conf.generic_sorter({}),
    }):find()
  else
    local items = vim.lsp.util.locations_to_items(locations)
    vim.fn.setqflist({}, " ", { title = title, items = items })
    vim.cmd("copen")
  end
end

-- References filtered by kind: 'read' or 'write'
function M.references(kind)
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = false }

  vim.lsp.buf_request(0, "textDocument/references", params, function(err, result)
    if err then
      vim.notify("LSP references error: " .. tostring(err.message or err), vim.log.levels.ERROR)
      return
    end
    if not result or vim.tbl_isempty(result) then
      vim.notify("Nessun riferimento trovato", vim.log.levels.INFO)
      return
    end

    local filtered = {}
    local any_has_kind = false

    for _, loc in ipairs(result) do
      local include = true

      -- Server-specific metadata detection
      local is_write = false
      local is_read = false

      if loc.isWriteAccess ~= nil then
        any_has_kind = true
        is_write = loc.isWriteAccess and true or false
        is_read = not is_write
      end

      if loc.role ~= nil then
        -- clangd role bitmask: Read=8, Write=16 (non-standard but common)
        any_has_kind = true
        local role = loc.role
        is_write = bit_and(role, 16) ~= 0
        is_read = bit_and(role, 8) ~= 0 and not is_write
      end

      if loc.kind ~= nil then
        -- Some servers might return a simple kind string
        any_has_kind = true
        local k = tostring(loc.kind):lower()
        if k:find("write") then is_write = true end
        if k:find("read") then is_read = true end
      end

      if kind == "write" then
        include = any_has_kind and is_write or true
      elseif kind == "read" then
        include = any_has_kind and is_read or true
      end

      if include then table.insert(filtered, loc) end
    end

    -- If filtering removed everything due to lack of metadata, fall back to all
    if any_has_kind and vim.tbl_isempty(filtered) then
      vim.notify("Nessun risultato filtrato; mostro tutti i riferimenti", vim.log.levels.INFO)
      filtered = result
    end

    local title = (kind == "write") and "LSP Writes" or "LSP Reads"
    show_locations(filtered, title)
  end)
end

return M
