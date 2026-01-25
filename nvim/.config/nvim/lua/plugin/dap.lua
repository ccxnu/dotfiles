vim.pack.add({
    { src = 'https://github.com/mfussenegger/nvim-dap' },
    { src = 'https://github.com/leoluz/nvim-dap-go'},
    { src = 'https://github.com/nvim-neotest/nvim-nio' },
    { src = 'https://github.com/rcarriga/nvim-dap-ui' },
})

local dap = require('dap')
local dapui = require('dapui')

require('dap-go').setup()

dap.configurations.go = {
    {
        type = 'go',
        name = 'Launch Chatbot (APIGO)',
        request = 'launch',
        -- ¡AJUSTAR ESTA RUTA!
        -- Si main.go está en 'cmd/', usar:
        program = '${workspaceFolder}/cmd',
        -- Si main.go está en la raíz del proyecto, usar:
        -- program = '${workspaceFolder}',
    },
}

dapui.setup()

-- Configurar DAPUI para que se abra y cierre automáticamente
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: Continue/Start' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out' })
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
vim.keymap.set('n', '<Leader>dt', require('dap-go').debug_test, { desc = 'DAP: Debug nearest test' })
