# error-jump.nvim

Give basic functionality for handling error messages in filename:line<:column> format

## Installation

### Packer
```lua
use ("Dr-42/error-jump.nvim")
```

## Configuration

It is useful to remap keybindings
Example:
```lua
vim.keymap.set('n', '<leader>es', require('error-jump').jump_to_error, { desc = '[E]rror [S]ource' })
vim.keymap.set('n', '<leader>en', require('error-jump').next_error, { desc = '[E]rror [N]ext' })
vim.keymap.set('n', '<leader>eN', require('error-jump').next_error, { desc = '[E]rror [N]previous' })
```

## Contributing

Feel free to make any pull requests
