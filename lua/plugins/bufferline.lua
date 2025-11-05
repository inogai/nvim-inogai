U.packadd "bufferline.nvim"

require "bufferline".setup {}

require "which-key".add {
  { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev Buffer" },
  { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next Buffer" },
  { "<leader>bd", "<cmd>BufferLinePickClose<cr>",   desc = "Close Buffer" },
  { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>",   desc = "Close Buffers to the Left" },
  { "<leader>bh", "<cmd>BufferLineCloseRight<cr>",  desc = "Close Buffers to the Right" },
  { "<leader>bk", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
  { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",   desc = "Pick Buffer" }
}
