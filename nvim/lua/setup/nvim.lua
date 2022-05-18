local const = require("utils.const")

const.define("fn", vim.fn)
const.define(
	"api",
	setmetatable({ _cache = {} }, {
		__index = function(self, name)
			if not self._cache[name] then
				local func = vim.api["nvim_" .. name]
				if func then
					self._cache[name] = func
				else
					error("nvim.api: No such api: " .. "'nvim_" .. name .. "'", 2)
				end
			end
			return self._cache[name]
		end,
	})
)

if fn.has("wsl") then
	const.define("OSTYPE", "WSL")
elseif fn.has("linux") == 1 then
	const.define("OSTYPE", "Linux")
elseif fn.has("win32") == 1 then
	const.define("OSTYPE", "Windows")
elseif fn.has("mac") == 1 then
	const.define("OSTYPE", "Mac")
end
