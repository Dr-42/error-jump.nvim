# error-jump.nvim

Give basic functionality for handling error messages in filename:line<:column> format.
Also has a compilation mode for easy edit, compile, jump to error, fix cycle.

## Installation

### Packer
```lua
use ("Dr-42/error-jump.nvim")
```

### Lazy
```lua
{
    "Dr-42/error-jump.nvim",
    name = "error-jump",
}
```

## Configuration

### Available functions

| Function         | Description                                                                            |
|------------------|----------------------------------------------------------------------------------------|
| compile()        | Opens a new compilation tab with the compile command you specified                     |
| jump_to_error()  | Jumps to the error location in the source file for a error of the form file:row:column |
| next_error()     | Jumps to the next error in the source file                                             |
| previous_error() | Jumps to the previous error in the source file                                         |

It is useful to remap keybindings

Example:
```lua
vim.keymap.set('n', '<leader>es', require('error-jump').jump_to_error, { desc = '[E]rror [S]ource' })
vim.keymap.set('n', '<leader>en', require('error-jump').next_error, { desc = '[E]rror [N]ext' })
vim.keymap.set('n', '<leader>eN', require('error-jump').next_error, { desc = '[E]rror [N]previous' })
vim.keymap.set('n', '<leader>ec', require('error-jump').compile, { desc = '[E]rror [C]ompile' })
```

## Contributing

Feel free to make any pull requests
