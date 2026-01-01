-- lua/plugins/init.lua
return {
    -- whichkey
    --
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup(opts)
            vim.keymap.set("n", "<leader>j", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
            vim.keymap.set("n", "<leader>k", function() vim.diagnostic.goto_prev() end, { desc = "Previous Diagnostic" })
            vim.keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Save file" })
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    -- Colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000, config = function()
            vim.cmd("colorscheme catppuccin-frappe")
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            -- vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            -- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        end,
    },

    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
            sync_install = false,
            auto_install = true,
            ignore_install = { "latex" },
            highlight = {
                enable = true,
                disable = { "latex" },
                additional_vim_regex_highlighting = false,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- Git integration
    {
        "tpope/vim-fugitive",
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    visual = "s",
                },
            })
        end
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                direction = "float",
                float_opts = {
                    border = "curved",
                },
                close_on_exit = true,
                terminal_mappings = true,
            })

            local Terminal = require("toggleterm.terminal").Terminal
            local float_term = Terminal:new({
                direction = "float",
                count = 1,
            })

            function _G.toggle_float()
                float_term:toggle()
            end

            vim.keymap.set({"n", "t"}, "<leader>t", "<cmd>lua toggle_float()<CR>", {
                noremap = true,
                silent = true,
                desc = "Toggle floating terminal",
            })
        end,
    },

    -- LazyGils 
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },

    -- Sidebar
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({
                view = {
                    width = 60,
                },
                git = {
                    enable = true,
                    -- This is the key setting to show files ignored by Git
                    ignore = false, 
                },
            })
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        end,
    },
    -- Start page
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },

    {
        'ibhagwan/fzf-lua',
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({})
            vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fuzzy find files" })
            vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fuzzy live grep" })
            vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fuzzy find buffers" })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏",
                },
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            -- recommended options for the best experience
            vim.opt.laststatus = 3 -- make statusline always visible
            vim.opt.cmdheight = 0 -- hide command line area

            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset theme here
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to lsp doc highlights
                },
            })
        end,
    },
    -- Blink.cmp 配置 (保持你的原有逻辑，稍作优化)
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat", -- 兼容层
        },
        version = '1.*', -- 建议使用 v0.* 除非你确定 v1 不会破坏配置
        opts = {
            -- keymap = { preset = 'default' },
            keymap = {
                ['<Tab>'] = { 'select_and_accept', 'fallback' },
                ['<CR>'] = { 'select_and_accept', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = true, 
                nerd_font_variant = 'mono'
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    lsp = {
                        name = 'LSP',
                        module = 'blink.cmp.sources.lsp',
                    },
                },
            },
            signature = { enabled = true }
        },
    },

    -- LSP and completion
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
                config = function()
                    require("mason").setup({
                        ensure_installed = {
                            "tree-sitter-cli",
                        },
                    })
                end,
            },
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Setup language servers.
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                ensure_installed = { "lua_ls", "clangd", "rust_analyzer" },
            })

            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end
                    vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
                end
                nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
                nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                nmap("gd", vim.lsp.buf.definition, "Go to Definition")
                nmap("gr", require("telescope.builtin").lsp_references, "Go to References")
                nmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
                nmap("K", vim.lsp.buf.hover, "Hover")
                nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Help")
            end

        end,
    },
    -- nvim-notify 配置
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_colour = "#000000",
            })
        end,
    },

    -- Formatter
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>lf",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                cpp = { "clang-format" },
                markdown = { "prettier" },
                tex = { "latexindent" },
            },
            format_on_save = function(bufnr)
                if vim.bo[bufnr].filetype == "markdown" or vim.bo[bufnr].filetype == "tex" or vim.bo[bufnr].filetype == "cpp" then
                    return { timeout_ms = 500, lsp_fallback = true }
                end
            end,
            formatters = {
                latexindent = {
                    -- 添加这些参数来禁止生成日志和备份
                    -- "-g /dev/null" 禁止生成 indent.log
                    -- "-y=defaultPoly:1" 是一个常用 hack，但关键是我们要覆盖 backup 设置
                    -- 我们可以尝试通过 YAML 参数覆盖：
                    prepend_args = { "-c", ".latexindent", "-y='lineWidth: 120'"},
                    -- args = { "-l", "-w", "-y='lineWidth:120'" },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- mini.icons 也行
        opts = {
            latex = { enabled = true } -- 确保开启 latex 支持
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        opts = {
            options = {
                mode = "buffers",
                numbers = "none",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context) return "("..count..")" end,
                show_buffer_close_icons = "all",
                show_close_icon = "all",
                color_icons = true,
                get_element_icon = function(element) return element.icon end,
            },
        },
    },

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- Flash.nvim
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        "milanglacier/minuet-ai.nvim",
        -- 使用 opts 替代手动 require setup
        opts = {
            -- 1. 配置 Ollama 后端 (通过 OpenAI 兼容接口)
            provider = "openai_compatible",
            request_timeout = 30000,
            context_window = 512,
            num_predict = 32,
            provider_options = {
                openai_compatible = {
                    -- model = "codellama", -- 替换为你本地 ollama list 中的模型名
                    model = 'qwen2.5-coder:1.5b', -- 换成 1.5b，速度起飞
                    end_point = 'http://localhost:11434/v1/chat/completions',
                    api_key = "TERM", -- 必须提供一个占位符字符串
                    name = "Ollama",
                    optional = {
                        num_ctx = 8192,      -- 限制上下文，防止 500 错误
                        num_predict = 16,   -- 每次只给一小段，体验最轻快
                    },
                    stream = false,
                },
            },
            -- 2. 配置 Ghost 模式 (Virtual Text)
            virtualtext = {
                auto_trigger_ft = { "*" }, -- 在所有文件类型中开启自动触发
                keymap = {
                    accept = "<Tab>",      -- Alt + Shift + a 接受全部
                    -- accept_line = "<A-a>", -- Alt + a 接受当前行
                    -- next = "<A-]>",        -- 切换下一个建议
                    -- prev = "<A-[>",        -- 切换上一个建议
                    -- dismiss = "<A-e>",     -- 隐藏建议
                },
            },
        },
    }
}
