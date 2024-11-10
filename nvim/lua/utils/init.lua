---write to file
---@param file_string string
---@param data any
function write_to_file(file_string, data)
  local file_path = file_string
  local file = io.open(file_path, "w")
  if file then
    file:write(vim.inspect(data))
    file:close()
    print("write success to " .. file_path)
  else
    print("Failed to open file" .. file_path .. " for writing.")
  end
end

---write to file at stdpath('config')
---@param file_string string
---@param data any
function write_to_local(file_string, data)
  local file_path = vim.fn.stdpath("config") .. "/" .. file_string
  local file = io.open(file_path, "w")
  if file then
    file:write(vim.inspect(data))
    file:close()
    print("write success to " .. file_path)
  else
    print("Failed to open file" .. file_path .. " for writing.")
  end
end
