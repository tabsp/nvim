local global = {}
local home = os.getenv("HOME")
local pathSep = global.isWindows and "\\" or "/"

function global.loadVariables()
  global.isMac = jit.os == "OSX"
  global.isLinux = jit.os == "Linux"
  global.isWindows = jit.os == "Windows"
  global.vimPath = home .. pathSep .. ".config" .. pathSep .. "nvim"
  global.cacheDir = home .. pathSep .. ".cache" .. pathSep .. "vim" .. pathSep
  global.modulesDir = global.vimPath .. pathSep .. "modules"
  global.pathSep = pathSep
  global.home = home
end

function global.readAll(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

function global.exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

function global.isDir(path)
  -- "/" works on both Unix and Windows
  return global.exists(path .. "/")
end

global.loadVariables()

return global
