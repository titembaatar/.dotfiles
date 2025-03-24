-- Define color variables at the top level
local base = "#172620"
local surface = "#21362d"
local overlay = "#2d493d"
local muted = "#4e7e6b"
local subtle = "#90bbaa"
local text = "#dfece7"
local low = "#39ac7e"
local mid = "#2d8662"
local high = "#206046"
local sarnai = "#f0c3cb"
local anis = "#ff6b6b"
local chatsalgan = "#e5951a"
local els = "#cca24d"
local uvs = "#80b946"
local nuur = "#2b879e"
local mus = "#9deaea"
local yargui = "#d5b3e5"
local none = "NONE"

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      -- on_colors = function(colors)
      --   colors.bg = base
      --   colors.bg_dark = surface
      --   colors.bg_dark1 = base
      --   colors.bg_float = surface
      --   colors.bg_highlight = overlay
      --   colors.bg_popup = surface
      --   colors.bg_search = sarnai
      --   colors.bg_sidebar = surface
      --   colors.bg_statusline = surface
      --   colors.bg_visual = sarnai
      --   colors.black = base
      --   colors.blue = nuur
      --   colors.blue0 = nuur
      --   colors.blue1 = mus
      --   colors.blue2 = mus
      --   colors.blue5 = mus
      --   colors.blue6 = mus
      --   colors.blue7 = sarnai
      --   colors.border = base
      --   colors.border_highlight = sarnai
      --   colors.comment = muted
      --   colors.cyan = mus
      --   colors.dark3 = muted
      --   colors.dark5 = subtle
      --   colors.diff = {
      --     add = uvs,
      --     change = overlay,
      --     delete = anis,
      --     text = overlay,
      --   }
      --   colors.error = anis
      --   colors.fg = text
      --   colors.fg_dark = subtle
      --   colors.fg_float = text
      --   colors.fg_gutter = muted
      --   colors.fg_sidebar = subtle
      --   colors.git = {
      --     add = uvs,
      --     change = nuur,
      --     delete = anis,
      --     ignore = muted,
      --   }
      --   colors.green = uvs
      --   colors.green1 = low
      --   colors.green2 = mid
      --   colors.hint = sarnai
      --   colors.info = mus
      --   colors.magenta = yargui
      --   colors.magenta2 = sarnai
      --   colors.none = none
      --   colors.orange = chatsalgan
      --   colors.purple = yargui
      --   colors.rainbow = {
      --     sarnai,
      --     nuur,
      --     yargui,
      --     mus,
      --     chatsalgan,
      --     els
      --   }
      --   colors.red = anis
      --   colors.red1 = anis
      --   colors.teal = sarnai
      --   colors.terminal = {
      --     black = base,
      --     black_bright = overlay,
      --     blue = nuur,
      --     blue_bright = nuur,
      --     cyan = mus,
      --     cyan_bright = mus,
      --     green = uvs,
      --     green_bright = uvs,
      --     magenta = sarnai,
      --     magenta_bright = sarnai,
      --     red = anis,
      --     red_bright = anis,
      --     white = text,
      --     white_bright = text,
      --     yellow = els,
      --     yellow_bright = els,
      --   }
      --   colors.terminal_black = overlay
      --   colors.todo = sarnai
      --   colors.warning = chatsalgan
      --   colors.yellow = els
      -- end
    },
  }
}
