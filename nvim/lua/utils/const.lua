-- from https://qiita.com/iigura/items/7f337ac766935d1dbcee
local M = {}
local constTable = {}

M.define = function(inName, inValue)
	if constTable[inName] ~= nil then
		error("const.define: '" .. inName .. "' is already defined.")
	end
	_G[inName] = nil
	constTable[inName] = inValue
end

M.overwrite = function(inName, inValue)
	constTable[inName] = inValue
end

M.undef = function(inName)
	if constTable[inName] ~= nil then
		constTable[inName] = nil
	end
end

local setter = function(inTable, inName, inValue)
	if inTable == _G and constTable[inName] ~= nil then
		error("'" .. inName .. "' is a const.")
	end
	rawset(inTable, inName, inValue)
end

setmetatable(_G, {
	__index = constTable,
	__newindex = setter,
})

return M
