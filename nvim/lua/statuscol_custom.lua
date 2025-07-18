local M = {}

function M.statuscolumn()
  local relnum = vim.v.relnum
  if relnum == 0 then
    return "8=ↄ~"  -- Letra na linha selecionada
  else
    return relnum  -- Número relativo nas outras linhas
  end
end

return M
