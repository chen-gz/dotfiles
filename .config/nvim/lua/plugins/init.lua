-- lua/plugins/init.lua

-- -- completion start qq
return {
    -- whichkey
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup(opts)
            vim.keymap.set("n", "<leader>j", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
            vim.keymap.set("n", "<leader>k", function() vim.diagnostic.goto_prev() end, { desc = "Previous Diagnostic" })
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
        opts = {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
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

    -- LSP Config (简单的占位符，确保 lsp 源有效)
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- 在这里设置你的 LSP，例如：
            -- require('lspconfig').lua_ls.setup({})
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
                markdown = { "prettier" },
                tex = { "latexindent" },
            },
            format_on_save = function(bufnr)
                if vim.bo[bufnr].filetype == "markdown" or vim.bo[bufnr].filetype == "tex" then
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

}
