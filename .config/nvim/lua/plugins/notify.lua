return {
    "rcarriga/nvim-notify",
    -- enabled = false, -- To  disable a plugin
    keys = {
        {
            "<leader>un",
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Delete all Notifications",
        },
    },
    opts = {
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        timeout = 1000,
        render = "compact",
        stages = "static",
    },
    init = function()
        -- when noice is not enabled, install notify on VeryLazy
        local Util = require("lazyvim.util")
        if not Util.has("noice.nvim") then
            Util.on_very_lazy(function()
                vim.notify = require("notify")
            end)
        end
    end,
}
