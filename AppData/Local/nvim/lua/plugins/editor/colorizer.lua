return {
  {
    "nvim-mini/mini.hipatterns",
    enabled = false,
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "LazyFile",
    opts = {
      user_default_options = {
        lazy_load = true,
        names = false,
        tailwind = true,
        mode = "virtualtext",
        virtualtext = "",
        virtualtext_inline = "before",
      },
    },
  },
  {
    "nvim-colorizer.lua",
    opts = function()
      local colorizer = require("colorizer")
      Snacks.toggle({
        name = "Colorizer",
        get = function()
          return colorizer.is_buffer_attached()
        end,
        set = function(state)
          if state then
            colorizer.attach_to_buffer()
          else
            colorizer.detach_from_buffer()
          end
        end,
      }):map("<leader>uH")
    end,
  },
}
