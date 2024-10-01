local M = {
	-- Underline the matched position
	vim.cmd('match Underlined /\\([^0-9:\\[\\] ][a-zA-Z0-9./\\\\_-]\\+:\\)\\(\\d\\+\\)\\(:\\d\\+\\)\\=/'),
	last_command = nil
}

local function recursive_list_files(path)
	local files = vim.fn.readdir(path)
	local result = {}
	for _, file in ipairs(files) do
		if file:sub(1, 1) == '.' then
			goto continue
		end
		local file_path = path .. '/' .. file
		if vim.fn.isdirectory(file_path) == 1 then
			local sub_files = recursive_list_files(file_path)
			for _, sub_file in ipairs(sub_files) do
				table.insert(result, sub_file)
			end
		else
			table.insert(result, file_path)
		end
		::continue::
	end
	return result
end

function M.jump_to_error()
	local error_info = vim.fn.expand('<cWORD>')

	local parts = vim.fn.split(error_info, ':')
	local filename = parts[1]
	local line = tonumber(parts[2])
	local col = tonumber(parts[3])

	-- Check if the error information is valid
	if tonumber(filename, 10) ~= nil then
		filename = nil
	end

	if not filename or not line then
		print("ERROR: ",
			"Expected: <filename>:<line>:<col> or <filename>:<line>",
			"Got: " .. error_info)
		return
	end

	-- Check if the direct filepath exists, if not, recursive list all files and match the filename if it is substring
	if vim.fn.filereadable(filename) == 0 then
		local files = recursive_list_files(vim.fn.getcwd())
		for _, file in ipairs(files) do
			if string.find(file, filename) then
				filename = file
				break
			end
		end
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
	local error_info = vim.fn.search("\\([^0-9:\\[\\] ][a-zA-Z0-9./\\\\_-]\\+:\\)\\(\\d\\+\\)\\(:\\d\\+\\)\\=", '')
	if error_info == 0 then
		print("No errors found")
		return
	end
end

function M.previous_error()
	-- look for any word with the format <filename>:<line>:<col> or <filename>:<line>
	local error_info = vim.fn.search("\\([^0-9:\\[\\] ][a-zA-Z0-9./\\\\_-]\\+:\\)\\(\\d\\+\\)\\(:\\d\\+\\)\\=", 'b')
	if error_info == 0 then
		print("No errors found")
		return
	end
end

function M.compile()
	local compile_command = vim.fn.input("Compile command: ", M.last_command or "")
	M.last_command = compile_command
	vim.cmd('terminal ' .. compile_command)
end

return M
