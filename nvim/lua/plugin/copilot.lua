vim.pack.add({
  {
    src = "https://github.com/zbirenbaum/copilot.lua",
    branch = "master",
    dir = vim.fn.stdpath("data") .. "/site/pack/copilot/opt/copilot.lua",
  }
})

vim.pack.add({
  {
    src = "https://github.com/copilotlsp-nvim/copilot-lsp",
    branch = "main",
    dir = vim.fn.stdpath("data") .. "/site/pack/copilot-lsp/opt/copilot-lsp",
  }
})

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd.packadd("copilot.lua")
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = "<M-w>",
          accept_line = "<M-L>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom",
          ratio = 0.4,
        },
      },
      filetypes = {
        ["*"] = true,
      },
      server_opts_overrides = {
        offset_encoding = "utf-16",
      },
    })
  end,
  once = true,
})
