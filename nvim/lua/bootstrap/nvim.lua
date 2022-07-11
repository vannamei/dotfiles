--/ Define const /--
local const = require("utils.const")

const.define("fn", vim.fn)

if fn.has("wsl") == 1 then
	const.define("OSTYPE", "WSL")
elseif fn.has("linux") == 1 then
	const.define("OSTYPE", "Linux")
elseif fn.has("win32") == 1 then
	const.define("OSTYPE", "Windows")
elseif fn.has("mac") == 1 then
	const.define("OSTYPE", "Mac")
end

--/ Python3 /--
local python3_dir = os.getenv("HOME") .. "/.python_env/nvim"
vim.g.python3_host_prog = python3_dir .. "/bin/python"
vim.env.PATH = python3_dir .. "/bin:" .. os.getenv("PATH")

require('bootstrap.autocommands')
require('bootstrap.options')
require('bootstrap.keymaps')
