local M = {
	-- Underline the matched position
	vim.cmd('match Underlined /\\([^0-9\\[\\] ][a-zA-Z0-9./\\\\_-]*:\\)\\(\\d*:\\)\\(\\d*\\)/'),
	vim.cmd('match Underlined /\\([^0-9\\[\\] ][a-zA-Z0-9./\\\\_-]*:\\)\\(\\d*:\\)/'),
}

function M.jump_to_error()
	local error_info = vim.fn.expand('<cWORD>')

	local parts = vim.fn.split(error_info, ':')
	local filename = parts[1]
	local line = tonumber(parts[2])
	local col = tonumber(parts[3])

	if not filename or not line then
		print("Invalid error information format")
		print("Expected: <filename>:<line>:<col>")
		print("Got: " .. error_info)
		return
	end

	vim.cmd('edit ' .. filename)
	if not col then
		vim.cmd('normal! ' .. line .. 'G')
		return
	else
		vim.cmd('normal! ' .. line .. 'G' .. col .. '|')
	end
end

function M.next_error()
	-- look for any word with the format <filename>:<line>:<col> or <filename>:<line>
	local error_info = vim.fn.search("\\([^0-9\\[\\] ][a-zA-Z0-9./\\\\_-]*:\\)\\(\\d*:\\)\\(\\d*\\)", '')
	if error_info == 0 then
		print("No errors found")
		return
	end
end

function M.previous_error()
	-- look for any word with the format <filename>:<line>:<col> or <filename>:<line>
	local error_info = vim.fn.search("\\([^0-9\\[\\]][a-zA-Z0-9./\\\\_-]*:\\)\\(\\d*:\\)\\(\\d*\\)", 'b')
	if error_info == 0 then
		error_info = vim.fn.search("\\([^0-9\\[\\]][a-zA-Z0-9./\\\\_-]*:\\)\\(\\d*:\\)", 'b')
		if error_info == 0 then
			print("No errors found")
			return
		end
		return
	end
end

return M
