return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- Performance and async settings
      auto_insert_mode = true, -- Automatically enter insert mode
      show_help = false, -- Disable help message on startup
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      separator = ' ', -- Separator to use in chat

      -- Window configuration for better performance
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = 'Copilot Chat', -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
      },

      -- Model configuration for better performance
      model = 'gpt-4.1', -- Use faster model

      -- Async and performance settings
      clear_chat_on_new_prompt = false, -- Don't clear chat, keeps context
      highlight_selection = true, -- Highlight the selected text
      context = nil, -- Default context to use (can be 'buffers', 'buffer', or 'file')
      history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Path to chat history
      callback = nil, -- Callback to use when ask response is received

      -- Selection settings for better UX
      selection = function(source)
        local select = require 'CopilotChat.select'
        return select.unnamed(source) -- Use unnamed register for selection
      end,

      -- Prompts configuration (optimized for speed)
      prompts = {
        Explain = {
          prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').line(source)
          end,
        },
        Review = {
          prompt = '/COPILOT_REVIEW Review the selected code.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Fix = {
          prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Optimize = {
          prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readability.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Docs = {
          prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Tests = {
          prompt = '/COPILOT_GENERATE Please generate tests for my code.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
      },

      -- Your existing mappings
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '<leader>qc',
        },
        reset = {
          normal = '<C-l>',
          insert = '<C-l>',
        },
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        toggle_sticky = {
          normal = 'grr',
        },
        clear_stickies = {
          normal = 'grx',
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        jump_to_diff = {
          normal = 'gj',
        },
        quickfix_answers = {
          normal = 'gqa',
        },
        quickfix_diffs = {
          normal = 'gqd',
        },
        yank_diff = {
          normal = 'gy',
          register = '"',
        },
        show_diff = {
          normal = 'gd',
          full_diff = false,
        },
        show_info = {
          normal = 'gi',
        },
        show_context = {
          normal = 'gc',
        },
        show_help = {
          normal = 'gh',
        },
      },
    },

    -- Optional: Add some convenient keymaps
    keys = {
      { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'CopilotChat' },
      { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>ct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - Fix code' },
      { '<leader>co', '<cmd>CopilotChatOptimize<cr>', desc = 'CopilotChat - Optimize code' },
      { '<leader>cd', '<cmd>CopilotChatDocs<cr>', desc = 'CopilotChat - Generate docs' },
    },
  },
}
