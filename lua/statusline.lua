local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"defx"}

local colors = {
  bg = "#282c34",
  linebg = "#21242b",
  fg = "#c0c0c0",
  yellow = "#fabd2f",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#afd700",
  orange = "#FF8800",
  purple = "#5d4d7a",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67"
}

local bufferNotEmpty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

modeColors = {
  n = colors.magenta,
  i = colors.green,
  v = colors.blue,
  V = colors.blue,
  c = colors.red,
  no = colors.magenta,
  s = colors.orange,
  S = colors.orange,
  [""] = colors.orange,
  ic = colors.yellow,
  R = colors.purple,
  Rv = colors.purple,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red
}
local getModeColor = function(mode)
  local color = modeColors[mode]
  if (color == nil) then
    color = colors.red
  end
  return color
end

local function findGitRoot()
  local path = vim.fn.expand("%:p:h")
  local getGitDir = require("galaxyline.provider_vcs").get_git_dir
  return getGitDir(path)
end

local checkWidth = function()
  local squeezeWidth = vim.fn.winwidth(0) / 2
  if squeezeWidth > 40 then
    return true
  end
  return false
end

gls.left = {
  {
    FirstElement = {
      provider = function()
        vim.api.nvim_command("hi GalaxyFirstElement guifg=" .. getModeColor(vim.fn.mode()))
        return "▊ "
      end,
      highlight = {colors.blue, colors.linebg}
    }
  },
  {
    ViMode = {
      provider = function()
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. getModeColor(vim.fn.mode()))
        return " "
      end,
      condition = bufferNotEmpty,
      highlight = {colors.darkblue, colors.linebg, "bold"}
    }
  },
  {
    FileIcon = {
      provider = "FileIcon",
      condition = bufferNotEmpty,
      highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.linebg}
    }
  },
  {
    FileName = {
      provider = {"FileName"},
      condition = bufferNotEmpty,
      highlight = {
        colors.red,
        colors.linebg,
        "bold"
      }
    }
  },
  {
    GitIcon = {
      provider = function()
        return "  "
      end,
      condition = findGitRoot,
      highlight = {colors.orange, colors.linebg}
    }
  },
  {
    GitBranch = {
      provider = "GitBranch",
      condition = findGitRoot,
      highlight = {colors.fg, colors.linebg, "bold"}
    }
  },
  {
    DiffAdd = {
      provider = "DiffAdd",
      condition = checkWidth,
      icon = "+",
      highlight = {colors.green, colors.linebg}
    }
  },
  {
    DiffModified = {
      provider = "DiffModified",
      condition = checkWidth,
      icon = "~",
      highlight = {colors.orange, colors.linebg}
    }
  },
  {
    DiffRemove = {
      provider = "DiffRemove",
      condition = checkWidth,
      icon = "-",
      highlight = {colors.red, colors.linebg}
    }
  },
  {
    LeftEnd = {
      provider = function()
        return ""
      end,
      separator = "",
      separator_highlight = {colors.bg, colors.linebg},
      highlight = {colors.linebg, colors.linebg}
    }
  },
  {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = {colors.red, colors.bg}
    }
  },
  {
    Space = {
      provider = function()
        return " "
      end
    }
  },
  {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = {colors.blue, colors.bg}
    }
  }
}

gls.right = {
  {
    FileTypeName = {
      provider = "FileTypeName",
      separator = " ",
      separator_highlight = {colors.bg, colors.linebg},
      highlight = {colors.fg, colors.linebg}
    }
  },
  {
    FileFormat = {
      provider = "FileFormat",
      separator = " | ",
      separator_highlight = {colors.blue, colors.linebg},
      highlight = {colors.fg, colors.linebg}
    }
  },
  {
    FileEncode = {
      provider = {"FileEncode"},
      separator = " |",
      separator_highlight = {colors.blue, colors.linebg},
      highlight = {colors.fg, colors.linebg, "bold"}
    }
  },
  {
    LineInfo = {
      provider = "LineColumn",
      separator = " | ",
      separator_highlight = {colors.blue, colors.linebg},
      highlight = {colors.fg, colors.linebg}
    }
  },
  {
    PerCent = {
      provider = "LinePercent",
      separator = " ",
      separator_highlight = {colors.linebg, colors.linebg},
      highlight = {colors.fg, colors.darkblue}
    }
  },
  {
    ScrollBar = {
      provider = "ScrollBar",
      highlight = {colors.blue, colors.purple}
    }
  }
}

gls.short_line_left = {
  {
    BufferType = {
      provider = "FileTypeName",
      separator = "",
      separator_highlight = {colors.purple, colors.bg},
      highlight = {colors.fg, colors.purple}
    }
  }
}

gls.short_line_right = {
  {
    BufferIcon = {
      provider = "BufferIcon",
      separator = "",
      separator_highlight = {colors.purple, colors.bg},
      highlight = {colors.fg, colors.purple}
    }
  }
}
