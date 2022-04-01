-- Globals
_G.fn = vim.fn
_G.api = setmetatable({ _cache = {} }, {
	__index = function(self, name)
		if not self._cache[name] then
			local func = vim.api["nvim_" .. name]
			if func then
				self._cache[name] = func
			else
				error("Unknown api function: nvim_" .. name, 2)
			end
		end
		return self._cache[name]
	end,
})

local M = {}

M.merge_functions = function(...)
	local fns = { ... }
	return function(...)
		for _, fn in ipairs(fns) do
			if fn ~= nil then
				fn(...)
			end
		end
	end
end

return M
