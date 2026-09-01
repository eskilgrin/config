vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function(ev)
    local path = vim.fn.fnamemodify(ev.file, ":p")
    vim.fn.jobstart({ "open", path }, { detach = true })
    vim.schedule(function()
      pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
    end)
  end,
})
