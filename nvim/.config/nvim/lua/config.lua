local o = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = ","

--- UI / Apariencia Visual
o.termguicolors = true -- Habilita colores de 24-bit
o.laststatus = 3 -- Siempre muestra la barra de estado
o.cmdheight = 0 -- Oculta la línea de comandos hasta que se necesite
o.showmode = false -- No mostrar el modo actual (ej. -- INSERT --)
o.showcmd = false
o.colorcolumn = "120" -- Línea vertical en la columna 100
o.signcolumn = "yes" -- Muestra siempre la columna de signos (para git, LSP, etc.)
o.cursorline = true -- Resalta la línea actual del cursor
o.cursorlineopt = "number" -- Resalta solo el número de la línea actual
o.number = true -- Muestra los números de línea
o.conceallevel = 0 -- Muestra todos los símbolos (ej. `*` en Markdown)
o.list = true -- No mostrar caracteres invisibles por defecto
o.listchars = { space = "·", trail = "⋅", tab = "→ " }
g.syntastic_auto_jump = 0 -- Don't jump on saving
o.completeopt = { "menuone", "noselect", "popup" }

--- Comportamiento del Editor
-- Indentación
-- p.expandtab = false -- Usa espacios en lugar de tabs
o.shiftwidth = 4 -- Tamaño de la indentación
o.tabstop = 4 -- Ancho de un carácter de tabulación
o.softtabstop = 0 -- Espacios a insertar/borrar al usar Tab/Backspace

-- Búsqueda
o.incsearch = true -- Muestra resultados de búsqueda mientras escribes
o.smartcase = true -- Ignora mayúsculas en la búsqueda si todo está en minúsculas

-- Ventanas y Splits
o.splitright = true -- Los nuevos splits verticales aparecen a la derecha
o.splitbelow = true -- Los nuevos splits horizontales aparecen abajo
-- p.splitkeep = "screen" -- Mantiene la posición del cursor en splits

-- General
o.clipboard = "unnamedplus" -- Sincronización con el portapapeles del sistema
o.mouse = "" -- Deshabilita el ratón
g.have_nerd_font = true
-- o.updatetime = 100 -- Tiempo para que se disparen eventos como CursorHold
-- p.timeoutlen = 400 -- Tiempo de espera para secuencias de teclas

--- Manejo de Archivos
o.swapfile = false -- No crear archivos swap
o.backup = false -- No crear archivos de backup
o.undofile = true -- Habilita el historial de deshacer persistente
o.undolevels = 10000 -- Niveles máximos de deshacer
o.lazyredraw = true

-- Ortografía
o.spelllang = { "es", "en" }
o.spell = false -- Deshabilitada por defecto

-- Rendimiento y Arranque
o.shortmess:append("csI") -- Deshabilita el mensaje de bienvenida de Neovim
o.syntax = "off" -- Deshabilita el motor de sintaxis por regex (opcional)

-- Disable unused providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_matchparen = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_tar = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_tutor_mode_plugin = 1
