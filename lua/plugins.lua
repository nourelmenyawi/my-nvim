local IS_DEV = false

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  {
    -- NEOVIM DEVELOPMENT SETUP
    "folke/neodev.nvim"
  }, {
  -- MAPPING IDENTIFIER
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.register({
      -- ["<leader>d"] = { name = "todo" },
      ["<leader>l"] = { name = "lsp" },
      ["<leader><leader>b"] = { name = "dap/debug" },
      ["<leader><leader>d"] = { name = "diagnostics/todos" },
      ["<leader><leader>f"] = { name = "format" },
      ["<leader><leader>g"] = { name = "git" },
      ["<leader><leader>l"] = { name = "lsp" },
      -- ["<leader><leader>n"] = {name = "noice"},
      ["<leader><leader>o"] = { name = "oil" },
      ["<leader><leader>p"] = { name = "plugins" },
      ["<leader><leader>q"] = { name = "quickfix" },
      ["<leader><leader>r"] = { name = "rust lsp" },
      ["<leader><leader>t"] = { name = "terminal" }
    })
  end
}, {
  -- COLORSCHEME
  "EdenEast/nightfox.nvim",
  lazy = false,    -- make sure we load this during startup as it is our main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function() vim.cmd("colorscheme nightfox") end
}, {
  { "nvim-neotest/nvim-nio" },
}, {
  "vim-test/vim-test",
  opts = {
    setup = {},
  },
  config = function(plugin, opts)
    vim.g["test#strategy"] = "neovim"
    vim.g["test#neovim#term_position"] = "belowright"
    vim.g["test#neovim#preserve_screen"] = 1

    -- Set up vim-test
    for k, _ in pairs(opts.setup) do
      opts.setup[k](plugin, opts)
    end
  end,
},
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-vim-test",
      "vim-test/vim-test",
    },
    keys = {
      { "<leader>ut", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File" },
      { "<leader>uT", function() require("neotest").run.run(vim.loop.cwd()) end,                          desc = "Run All Test Files" },
      { "<leader>ur", function() require("neotest").run.run() end,                                        desc = "Run Nearest" },
      { "<leader>ul", function() require("neotest").run.run_last() end,                                   desc = "Run Last" },
      { "<leader>us", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary" },
      { "<leader>uo", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>uO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel" },
      { "<leader>uS", function() require("neotest").run.stop() end,                                       desc = "Stop" },
    },
    opts = function()
      return {
        adapters = {
          require "neotest-vim-test" {
            ignore_file_types = { "python", "vim", "lua" },
          },
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup(opts)
    end,
  }, {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    })
  end
},
  {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup(
        {
          -- Save modified buffer(s) when moving to mux
          -- nil - Don't save (default)
          -- 'current' - Only save the current modified buffer
          -- 'all' - Save all the buffers
          auto_save = nil,

          -- Disable navigation when the current mux pane is zoomed in
          disable_on_zoom = false,

          -- Multiplexer to use
          -- 'auto' - Chooses mux based on priority (default)
          -- table - Custom mux to use
          mux = 'auto'
        }
      )
    end
  },
  { "f-person/git-blame.nvim" },
  { 'dmmulroy/ts-error-translator.nvim' },
  { "sindrets/diffview.nvim" },
  { 'github/copilot.vim' },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   branch = "canary",
  --   dependencies = {
  --     { "github/copilot.vim" },    -- or github/copilot.vim
  --     { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  --   },
  --   opts = {
  --     debug = true, -- Enable debugging
  --     -- See Configuration section for rest
  --   },
  --   keys = {
  --     {
  --       "<leader>zq",
  --       function()
  --         local input = vim.fn.input("Quick Chat: ")
  --         if input ~= "" then
  --           require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  --         end
  --       end,
  --       desc = "CopilotChat - Quick chat",
  --     },
  --     {
  --       "<leader>zx",
  --       ":CopilotChatInline<cr>",
  --       mode = "x",
  --       desc = "CopilotChat - Inline chat",
  --     },
  --     -- See Commands section for default commands if you want to lazy load on them
  --   },
  -- },
  {
    -- { import = "github/copilot.vim" }, -- Or use { import = "lazyvim.plugins.extras.coding.copilot" },
    {
      dir = IS_DEV and "~/Projects/research/CopilotChat.nvim" or nil,
      "CopilotC-Nvim/CopilotChat.nvim",
      version = "v2.8.0",
      -- branch = "canary", -- Use the canary branch if you want to test the latest features but it might be unstable
      -- Do not use branch and version together, either use branch or version
      dependencies = {
        { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
        { "nvim-lua/plenary.nvim" },
      },
      opts = {
        question_header = "## User ",
        answer_header = "## Copilot ",
        error_header = "## Error ",
        separator = " ",            -- Separator to use in chat
        prompts = prompts,
        auto_follow_cursor = false, -- Don't follow the cursor after getting response
        show_help = false,          -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
        mappings = {
          -- Use tab for completion
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          -- Close the chat
          close = {
            normal = "q",
            insert = "<C-c>",
          },
          -- Reset the chat buffer
          reset = {
            normal = "<C-l>",
            insert = "<C-l>",
          },
          -- Submit the prompt to Copilot
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-CR>",
          },
          -- Accept the diff
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
          -- Yank the diff in the response to register
          yank_diff = {
            normal = "gmy",
          },
          -- Show the diff
          show_diff = {
            normal = "gmd",
          },
          -- Show the prompt
          show_system_prompt = {
            normal = "gmp",
          },
          -- Show the user selection
          show_user_selection = {
            normal = "gms",
          },
        },
      },
      config = function(_, opts)
        local chat = require("CopilotChat")
        local select = require("CopilotChat.select")
        -- Use unnamed register for the selection
        opts.selection = select.unnamed

        -- Override the git prompts message
        opts.prompts.Commit = {
          prompt = "Write commit message for the change with commitizen convention",
          selection = select.gitdiff,
        }
        opts.prompts.CommitStaged = {
          prompt = "Write commit message for the change with commitizen convention",
          selection = function(source)
            return select.gitdiff(source, true)
          end,
        }

        chat.setup(opts)

        vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
          chat.ask(args.args, { selection = select.visual })
        end, { nargs = "*", range = true })

        -- Inline chat with Copilot
        vim.api.nvim_create_user_command("CopilotChatInline", function(args)
          chat.ask(args.args, {
            selection = select.visual,
            window = {
              layout = "float",
              relative = "cursor",
              width = 1,
              height = 0.4,
              row = 1,
            },
          })
        end, { nargs = "*", range = true })

        -- Restore CopilotChatBuffer
        vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
          chat.ask(args.args, { selection = select.buffer })
        end, { nargs = "*", range = true })

        -- Custom buffer for CopilotChat
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = "copilot-*",
          callback = function()
            vim.opt_local.relativenumber = true
            vim.opt_local.number = true

            -- Get current filetype and set it to markdown if the current filetype is copilot-chat
            local ft = vim.bo.filetype
            if ft == "copilot-chat" then
              vim.bo.filetype = "markdown"
            end
          end,
        })

        -- Add which-key mappings
        local wk = require("which-key")
        wk.register({
          g = {
            m = {
              name = "+Copilot Chat",
              d = "Show diff",
              p = "System prompt",
              s = "Show selection",
              y = "Yank diff",
            },
          },
        })
      end,
      event = "VeryLazy",
      keys = {
        -- Show help actions with telescope
        {
          "<leader>zh",
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.help_actions())
          end,
          desc = "CopilotChat - Help actions",
        },
        -- Show prompts actions with telescope
        {
          "<leader>zp",
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
          end,
          desc = "CopilotChat - Prompt actions",
        },
        {
          "<leader>zp",
          ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
          mode = "x",
          desc = "CopilotChat - Prompt actions",
        },
        -- Code related commands
        { "<leader>ze", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
        { "<leader>zt", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
        { "<leader>zr", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
        { "<leader>zR", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
        { "<leader>zn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
        -- Chat with Copilot in visual mode
        {
          "<leader>zv",
          ":CopilotChatVisual",
          mode = "x",
          desc = "CopilotChat - Open in vertical split",
        },
        {
          "<leader>zx",
          ":CopilotChatInline<cr>",
          mode = "x",
          desc = "CopilotChat - Inline chat",
        },
        -- Custom input for CopilotChat
        {
          "<leader>zi",
          function()
            local input = vim.fn.input("Ask Copilot: ")
            if input ~= "" then
              vim.cmd("CopilotChat " .. input)
            end
          end,
          desc = "CopilotChat - Ask input",
        },
        -- Generate commit message based on the git diff
        {
          "<leader>zm",
          "<cmd>CopilotChatCommit<cr>",
          desc = "CopilotChat - Generate commit message for all changes",
        },
        {
          "<leader>zM",
          "<cmd>CopilotChatCommitStaged<cr>",
          desc = "CopilotChat - Generate commit message for staged changes",
        },
        -- Quick chat with Copilot
        {
          "<leader>zq",
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              vim.cmd("CopilotChatBuffer " .. input)
            end
          end,
          desc = "CopilotChat - Quick chat",
        },
        -- Debug
        { "<leader>zd", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
        -- Fix the issue with diagnostic
        { "<leader>zf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
        -- Clear buffer and chat history
        { "<leader>zl", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },
        -- Toggle Copilot Chat Vsplit
        { "<leader>zv", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle" },
      },
    },
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      -- 'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      -- 'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
