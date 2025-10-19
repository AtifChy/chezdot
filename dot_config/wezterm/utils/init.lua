---@class Utils
local M = {}

---@param dst table
---@param src table
function M.merge(dst, src)
	for k, v in pairs(src) do
		dst[k] = v
	end
end

---@param dst table
---@param src table
function M.deep_merge(dst, src)
	for k, v in pairs(src) do
		if type(v) == "table" and type(dst[k]) == "table" then
			M.deep_merge(dst[k], v)
		else
			dst[k] = v
		end
	end
end

---@param hex string
---@param alpha number
---@return string
function M.hex_to_rgba(hex, alpha)
	local r = tonumber(hex:sub(2, 3), 16)
	local g = tonumber(hex:sub(4, 5), 16)
	local b = tonumber(hex:sub(6, 7), 16)
	return string.format("rgba(%d, %d, %d, %.2f)", r, g, b, alpha)
end

return M
