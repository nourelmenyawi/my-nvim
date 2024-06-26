return {
  {
    -- GIT BLAME
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup({
        date_format = "%Y.%m.%d",
      })
    end,
    keys = {
      {
        "<leader><leader>gb",
        function() vim.cmd("BlameToggle") end,
        desc = "Toggle git blame",
        mode = "n",
        noremap = true,
        silent = true
      },
    }
  },
  {
    -- GIT CHANGE INDICATOR
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { desc = "next change hunk", expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { desc = "prev change hunk", expr = true })

          -- map('n', '<leader><leader>gb',
          --   function()
          --     gs.blame_line { full = true }
          --   end, { desc = "git blame" })

          -- map('n', '<leader><leader>gb',
          --   function() gs.blame_line {} end,
          --   { desc = "git blame short" })

          map('n', '<leader><leader>gd', gs.diffthis,
            { desc = "git diff (:q to close)" })
        end
      })
    end
  }, {
  -- GIT HISTORY
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("diffview").setup()
    vim.keymap.set("n", "<leader><leader>gh",
      "<Cmd>DiffviewFileHistory<CR>",
      { desc = "show project commit history" })
    vim.keymap.set("n", "<leader><leader>go", "<Cmd>DiffviewOpen<CR>",
      { desc = "show uncommitted file changes" })
    vim.keymap.set("n", "<leader><leader>gc", "<Cmd>DiffviewClose<CR>",
      { desc = "close diffview window" })
  end
}, {
  -- OPEN LINES IN GITHUB
  "ruanyl/vim-gh-line",
  keys = {
    {
      "<leader><leader>gl",
      function() vim.cmd("GH") end,
      desc = "Open single line in GitHub's web UI",
      noremap = true,
      silent = true
    }
  },
  config = true
}
}
