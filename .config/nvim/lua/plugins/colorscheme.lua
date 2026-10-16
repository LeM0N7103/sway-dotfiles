return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true, -- let foot's background and alpha show through
      theme = "dragon",   -- "wave" (default), "dragon", or "lotus"
      background = { dark = "dragon", light = "lotus" },
      colors = {
        theme = {
          all = { ui = { bg_gutter = "none" } }, -- no colored sign/number column
        },
      },
      overrides = function()
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "kanagawa" },
  },
}
