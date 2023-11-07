local vim = vim

vim.g.targets_nl = { 'l', 'h' }

local group = vim.api.nvim_create_augroup('CustomTargetsGroup', { clear = true })
vim.api.nvim_create_autocmd('User', {
    pattern = 'targets#mappings#user',
    callback = function()
        vim.api.nvim_call_function('targets#mappings#extend', {
            {
                a = { argument = {
                    { o = '(', c = ')', s = ',' },
                    { o = '{', c = '}', s = ',' },
                    { o = '[', c = ']', s = ',' },
                    { o = '<', c = '>', s = ',' },
                } },
                b = { pair = {
                    { o = '(', c = ')' },
                    { o = '{', c = '}' },
                    { o = '[', c = ']' },
                    { o = '<', c = '>' },
                } },
            }
        })
    end,
    group = group,
})
