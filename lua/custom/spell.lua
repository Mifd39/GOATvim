-- lua/custom/spell.lua

local M = {}

-- Function to toggle spell check and cycle languages
function M.toggle_spell()
  if vim.opt.spell:get() then
    -- Spell is currently on, check language
    local current_lang_list = vim.opt.spelllang:get()
    local current_lang = current_lang_list[1]
    if current_lang == 'en' then
      vim.opt.spelllang = { 'da' }
      vim.notify('Spell check: ON (Danish)')
    elseif current_lang == 'da' then
      vim.opt.spell = false
      vim.notify('Spell check: OFF')
    else
      -- Fallback if spelllang is something unexpected or multiple languages are set
      vim.opt.spell = false
      vim.notify('Spell check: OFF (unexpected language, turned off)')
    end
  else
    -- Spell is currently off, turn it on with English
    vim.opt.spell = true
    vim.opt.spelllang = { 'en' }
    vim.notify('Spell check: ON (English)')
  end
end

-- Set up keybinding
vim.keymap.set('n', '<leader>sp', M.toggle_spell, { desc = '[S]pell [P]check Toggle' })

return M
