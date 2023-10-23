vim.g.mapleader = ' '

local function am(a, b, o) qnoremap('' , a, b, o) end
local function im(a, b, o) qnoremap('i', a, b, o) end
local function cm(a, b, o) qnoremap('c', a, b, o) end
local function nm(a, b, o) qnoremap('n', a, b, o) end
local function xm(a, b, o) qnoremap('x', a, b, o) end
local function om(a, b, o) qnoremap('o', a, b, o) end

--vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

nm('Q', '<Nop>')
nm('ZZ', '<Nop>')
nm(']]', '<Nop>')
nm('[[', '<Nop>')
nm('gg', '<Nop>')

am('<left>', '<Nop>')
am('<right>', '<Nop>')
am('<up>', '<Nop>')
am('<down>', '<Nop>')

am('<S-left>', '<Nop>')
am('<S-right>', '<Nop>')
am('<S-up>', '<Nop>')
am('<S-down>', '<Nop>')

am('<C-left>', '<Nop>')
am('<C-right>', '<Nop>')
am('<C-up>', '<Nop>')
am('<C-down>', '<Nop>')

-- absolute search diraction
local searchOpt = { expr = true, remap = false }

vim.keymap.set('n', 'n', "v:searchforward ? 'n' : 'N'", searchOpt)
vim.keymap.set('n', 'N', "v:searchforward ? 'N' : 'n'", searchOpt)


im('<esc>', '<esc>`^') -- prevent cursor from moving when exiting insert mode
im('<C-c>', '<C-c>`^')

nm('$', '$l')

nm('<space>', 'i <esc>`^')
nm('<bs>', 'i<bs><esc>`^')
nm('<enter>', 'i<enter><esc>`^')

nm('<C-z>', ':undo<cr>')
nm('<C-S-z>', ':redo<cr>')

nm('<C-s>', ':%s//gc<left><left><left>') --replace on C-s
xm('<C-s>', ':%s//gc<left><left><left>')

nm('>>', 'i<C-t><Esc>`^') --tabs keep cursor in the same place
nm('<<', 'i<C-d><Esc>`^')

nm(')', '<C-y>') -- move screen immediately without cursor
nm('(', '<C-e>')

nm('{', '_') -- move to start/end of line without leading spaces
xm('{', '_')
nm('}', 'g_')
xm('}', 'g_')

im('<C-k>', '<up>') -- navigation in insert/command mode (instead of arrows)
im('<C-h>', '<left>')
im('<C-j>', '<down>')
im('<C-l>', '<right>')
cm('<C-k>', '<up>')
cm('<C-h>', '<left>')
cm('<C-j>', '<down>')
cm('<C-l>', '<right>')

vim.keymap.set('n', 'J', "winheight(0)/4.'jzz'", { expr = true })
vim.keymap.set('n', 'K', "winheight(0)/4.'kzz'", { expr = true }) 
--vim.keymap.set('x', 'J', "winheight(0)/4.'jzz'", { expr = true })
--vim.keymap.set('x', 'K', "winheight(0)/4.'kzz'", { expr = true })
vim.keymap.set('n', 'H', '10h', { remap = true })
vim.keymap.set('n', 'L', '10l', { remap = true })
vim.keymap.set('x', 'H', '10h', { remap = true })
vim.keymap.set('x', 'L', '10l', { remap = true })

-- join lines
nm('gj', 'J')
nm('gJ', 'kJ')

nm('<leader>u', ":UndotreeShow<cr>")

xm('<S-j>', ":m '>+1<cr>gv=gv") --move secection up/down
xm('<S-k>', ":m '<-2<cr>gv=gv")

xm('gp', "\"_dP")

-- work with system clipboard without mentioning the register
nm('<leader>y', "\"+y")
nm('<leader>Y', "\"+Y")
xm('<leader>y', "\"+y")

nm('<leader>p', "\"+p")
nm('<leader>P', "\"+P")
xm('<leader>p', "\"+p")

nm('<leader>d', "\"+d")
nm('<leader>D', "\"+D")
xm('<leader>d', "\"+d")


-- some old vim remappings that I have no idea how to replace
local oldBindingsLoaded = pcall(require, 'main.oldVim')
if not oldBindingsLoaded then
    print "ERROR: old bindings not loaded!"
else
    -- line without indentation and newline
    om('<leader>l', ":<C-u>normal! _vg_l<cr>")
    nm('d<leader>l', "_vg_d\"_dd")
    nm('y<leader>l', "_vg_y`^")
    xm('<leader>l', "<esc>_vg_")

    --variable/property left hand size
    om('<leader>v', ":<C-u>call SelectVariableValue(0)<cr>")
    nm('d<leader>v', ":call ExecDelLines(0)<cr>")
    xm('<leader>v', "<Esc>: call SelectVariableValue(0)<cr>")
    nm('y<leader>v', ":call SelectVariableValue(0)<cr>y`^")

    om('<leader>V', ":<C-u>call SelectVariableValue(1)<cr>")
    nm('d<leader>V', ":call ExecDelLines(1)<cr>")
    xm('<leader>V', "<Esc>:call SelectVariableValue(1)<cr>")
    nm('y<leader>V', ":call SelectVariableValue(1)<cr>y`^")

    om('<leader><C-v>', ":<C-u>call SelectVariableValue(2)<cr>")
    nm('d<leader><C-v>', ":call ExecDelLines(2)<cr>")
    xm('<leader><C-v>', "<Esc>:call SelectVariableValue(2)<cr>")
    nm('y<leader><C-v>', ":call SelectVariableValue(2)<cr>y`^")

    --go to function declaration from where it is called
    nm('g<leader>f', ":call GoToFunctionDecl()<cr>")

    --select one part of camelCase word (special case if the word contains uppercase acronym/abbreviation, doesn't work with numbers etc.)
    nm('<leader>q', ":call MoveCapitalWord()<cr>")
    xm('<leader>q', "<Esc>: call SelectCapitalWord()<cr>")
    om('<leader>q', ":<C-u>call SelectCapitalWord()<cr>")


    --execute current line/selection
    nm('<leader>rdk', ":call CallLine(v:true, function('ExecKeys'))<cr>")
    nm('<leader>rdv', ":call CallLine(v:true, function('ExecVim'))<cr>")
    nm('<leader>rdl', ":call CallLine(v:true, function('ExecLua'))<cr>")

    xm('<leader>rdk', ":call CallSelection(v:true, function('ExecKeys'))<cr>")
    xm('<leader>rdv', ":call CallSelection(v:true, function('ExecVim'))<cr>")
    xm('<leader>rdl', ":call CallSelection(v:true, function('ExecLua') )<cr>")

    nm('<leader>rk', ":call CallLine(v:false, function('ExecKeys'))<cr>")
    nm('<leader>rv', ":call CallLine(v:false, function('ExecVim'))<cr>")
    nm('<leader>rl', ":call CallLine(v:false, function('ExecLua'))<cr>")

    xm('<leader>rk', ":call CallSelection(v:false, function('ExecKeys'))<cr>")
    xm('<leader>rv', ":call CallSelection(v:false, function('ExecVim'))<cr>")
    xm('<leader>rl', ":call CallSelection(v:false, function('ExecLua') )<cr>")
end
