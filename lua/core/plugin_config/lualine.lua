local lualine = require('lualine')
local duskfox = require('nightfox.palette').load("duskfox")

local colors = {
    red         = duskfox.red.base,
    yellow      = duskfox.yellow.base,
    blue        = duskfox.blue.base,
    magenta     = duskfox.magenta.base,
    cyan        = duskfox.cyan.dim,
    white       = duskfox.white.base,
    bg          = duskfox.bg0,
    bg2         = duskfox.bg4,
}

-- Config
local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = {
      normal    = { c = { fg = colors.white, bg = colors.bg } },
      inactive  = { c = { fg = colors.white, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local mode_color = {
    n       =   { mode = "NORMAL",      color = colors["cyan"]      },
    no      =   { mode = "NORMAL",      color = colors["cyan"]      },
    i       =   { mode = "INSERT",      color = colors["white"]     },
    v       =   { mode = "VISUAL",      color = colors["magenta"]   },
    V       =   { mode = "V-LINE",      color = colors["magenta"]   },
    [""]  =   { mode = "V-BLOCK",     color = colors["magenta"]   },
    c       =   { mode = "COMMAND",     color = colors["yellow"]    },
    cv      =   { mode = "COMMAND",     color = colors["yellow"]    },
    ce      =   { mode = "COMMAND",     color = colors["yellow"]    },
    R       =   { mode = "REPLACE",     color = colors["red"]       },
    Rv      =   { mode = "REPLACE",     color = colors["red"]       },
    s       =   { mode = "SELECT",      color = colors["magenta"]   },
    S       =   { mode = "SELECT",      color = colors["magenta"]   },
    ['']  =   { mode = "SELECT",      color = colors["magenta"]   },
    t       =   { mode = "TERMINAL",    color = colors["blue"]      },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

local function get_main_mode_color()
   return mode_color[vim.fn.mode()]["color"]
end

local main_mode_color = function()
    return mode_color[vim.fn.mode()]["color"]
end

local function main_mode_color_group()
    return {
        bg = main_mode_color(),
        fg = colors.bg,
        gui = "bold"
    }
end

----------------
-- LEFT SECTION
----------------
-- MODE
ins_left {
    function()
        return string.format(" %s ", mode_color[vim.fn.mode()]["mode"])
    end,
    color = function () return main_mode_color_group() end,
    padding = {
        right = 0
    },
}

------ GIT BRANCH
ins_left {
    'branch',
    icon = '',
    color = {
        fg = colors.bg2,
    },
}

-- FILENAME
ins_left {
    function() return " " end,
    color = {
        bg = colors.bg2,
        fg = colors.bg
    },
    padding = 0,
}
ins_left {
    'filename',
    color = {
        bg = colors.bg2,
        fg = colors.white
    },
    padding = 0,
}
ins_left {
    function() return " " end,
    color = {
        bg = colors.bg2,
        fg = colors.bg
    },
    padding = 0
}

----------------
-- RIGHT SECTION
----------------
-- DIAGNOSTICS
ins_right {
    'diagnostics',
    sources = { 'coc' },
    symbols = {
        error = ' ',
        warn = ' ',
        info = ' '
    },
    diagnostics_color = {
        color_error = { fg = colors.red     },
        color_warn  = { fg = colors.yellow  },
        color_info  = { fg = colors.cyan    },
    },
}

-- ENCODING
ins_right {
    function() return '' end,
    color = function () return {
        fg = colors.bg2,
        bg = colors.bg,
    } end,
    padding = 0,
}
ins_right {
    'encoding',
    color = function () return {
        bg = colors.bg2,
        fg = colors.white
    } end,
}

-- LOCATION
ins_right {
    function() return '' end,
    color = function () return {
        fg = get_main_mode_color(),
        bg = colors.bg2,
    } end,
    padding = 0
}
ins_right {
    'location',
    color = function () return main_mode_color_group() end,
}

-- PROGRESS
ins_right {
    function() return '' end,
    color = function () return main_mode_color_group() end,
    padding = 0
}
ins_right {
    'progress',
    color = function () return main_mode_color_group() end,
}

lualine.setup(config)
