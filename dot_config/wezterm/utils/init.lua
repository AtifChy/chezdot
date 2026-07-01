---@class Utils
local M = {}

---@param dst table
---@param src table
---@return table
function M.merge(dst, src)
	for k, v in pairs(src) do
		dst[k] = v
	end
	return dst
end

---@param dst table
---@param src table
---@return table
function M.deep_merge(dst, src)
	for k, v in pairs(src) do
		if type(v) == "table" and type(dst[k]) == "table" then
			M.deep_merge(dst[k], v)
		else
			dst[k] = v
		end
	end
	return dst
end

---@param dst any[]
---@param src any[]
---@return any[]
function M.extend(dst, src)
	for _, v in ipairs(src) do
		dst[#dst + 1] = v
	end
	return dst
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

local superscript_numbers = {
	["0"] = "⁰",
	["1"] = "¹",
	["2"] = "²",
	["3"] = "³",
	["4"] = "⁴",
	["5"] = "⁵",
	["6"] = "⁶",
	["7"] = "⁷",
	["8"] = "⁸",
	["9"] = "⁹",
}

---@param str string
function M.to_superscript(str)
	return str:gsub("%d", function(digit)
		return superscript_numbers[digit] or digit
	end)
end

return M
