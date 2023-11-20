local M = {}

function M.jump_to_error()
	--[[ -- Get the current line
	local current_line = vim.fn.getline('.')
	-- Get the cursor position
	local cursor_col = vim.fn.col('.')

	-- Get the error information
	local error_info = vim.fn.system('rg --vimgrep ' .. current_line) ]]

	local error_info = vim.fn.expand('<cWORD>')

	local parts = vim.fn.split(error_info, ':')
	local filename = parts[1]
	local line = tonumber(parts[2])
	local col = tonumber(parts[3])

	if not filename or not line or not col then
		print("Invalid error information format")
		print("Expected: <filename>:<line>:<col>")
		print("Got: " .. error_info)
		return
	end

	vim.cmd('tabnew')
	vim.cmd('edit ' .. filename)
	vim.cmd('normal! ' .. line .. 'G' .. col .. '|')
end

return M
