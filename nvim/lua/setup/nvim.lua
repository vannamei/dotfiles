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
