-- lua/plugins/init.lua

return {
    -- Colorscheme
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme catppuccin")
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
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    -- Git integration
    {
        "tpope/vim-fugitive",
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
                -- filters = {
                --     ignore = false,
                --     custom = { "gitignore" },
                -- },
            })
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
        end,
    },

    -- Project management
    -- {
    --     "ahmedkhalf/project.nvim",
    --     config = function()
    --         require("project_nvim").setup({})
    --         require('telescope').load_extension('projects')
    --     end,
    -- },

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
}
