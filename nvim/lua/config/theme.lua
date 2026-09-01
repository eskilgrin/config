local themes = {
  "catppuccin",
  "tokyonight",
  "kanagawa",
}

local function choose_theme()
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Colorschemes",

      finder = require("telescope.finders").new_table({
        results = themes,
      }),

      sorter = require("telescope.config").values.generic_sorter({}),

      attach_mappings = function(prompt_bufnr, map)
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local function apply_theme()
          local selection = action_state.get_selected_entry()

          actions.close(prompt_bufnr)

          vim.cmd.colorscheme(selection.value)
        end

        map("i", "<CR>", apply_theme)
        map("n", "<CR>", apply_theme)

        return true
      end,
    })
    :find()
end

vim.keymap.set("n", "<leader>ft", choose_theme, {
  desc = "Choose colorscheme",
})
