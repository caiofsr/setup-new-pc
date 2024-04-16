return {{
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    config = function()
        require "configs.conform"
    end
}, {
    "neovim/nvim-lspconfig",
    config = function()
        require("nvchad.configs.lspconfig").defaults()
        require "configs.lspconfig"
    end
}, {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {"lua-language-server", "stylua", "html-lsp", "css-lsp", "prettier",
                            "typescript-language-server", "gopls"}
    }
}, {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {"vim", "lua", "vimdoc", "html", "css", "typescript", "go", "dockerfile", "proto", "bash",
                            "javascript", "sql", "jsdoc", "markdown", "yaml"}
    }
}}
