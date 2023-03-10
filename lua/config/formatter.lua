local util = require 'formatter.util'

require('formatter').setup{
logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {cpp = require('formatter.filetypes.cpp').clangformat, c = require('formatter.filetypes.c').clangformat  }

}
