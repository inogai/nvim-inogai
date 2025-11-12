# Migration Guide: Converting nixCats Config to Use lze

This configuration has been refactored to use [lze](https://github.com/BirdeeHub/lze) for lazy loading plugins instead of manual `packadd` calls.

## What Changed

1. **Added lze to flake inputs** - lze is now included as a dependency
2. **Created lze-based plugin structure** - New `lua/lze_specs/` directory for plugin specifications
3. **Updated init.lua** - Now uses lze for loading plugins instead of manual `U.packadd()` calls
4. **Updated neovim.lua** - Plugin loading is now handled by lze automatically

## How to Convert Remaining Plugins

### Basic Conversion Pattern

**Old way (in lua/plugins/):**
```lua
U.packadd('plugin-name.nvim')

local plugin = require('plugin-name')
plugin.setup({
  -- config here
})

require('which-key').add({
  { '<leader>key', function() plugin.some_function() end, desc = 'Description' },
})
```

**New way (in lua/lze_specs/):**
```lua
return {
  "plugin-name.nvim",
  event = "VimEnter", -- or other trigger
  after = function()
    require("plugin-name").setup({
      -- config here
    })
    
    require("which-key").add({
      { "<leader>key", function() require("plugin-name").some_function() end, desc = "Description" },
    })
  end,
}
```

### Common Trigger Types

1. **Event-based loading:**
   ```lua
   event = "VimEnter"           -- Load when Neovim starts
   event = "BufEnter"           -- Load when entering a buffer
   event = "InsertEnter"        -- Load when entering insert mode
   event = { "BufReadPost", "BufNewFile" }  -- Multiple events
   ```

2. **Key-based loading:**
   ```lua
   keys = {
     { "<leader>f", function() require("plugin").function() end, desc = "Description" },
     { "<leader>g", "<cmd>PluginCommand<cr>", desc = "Command description" },
   }
   ```

3. **Command-based loading:**
   ```lua
   cmd = "PluginCommand"
   cmd = { "Command1", "Command2" }  -- Multiple commands
   ```

4. **Filetype-based loading:**
   ```lua
   ft = "python"
   ft = { "python", "javascript", "lua" }  -- Multiple filetypes
   ```

5. **Plugin dependencies:**
   ```lua
   on_plugin = "base-plugin.nvim"    -- Load after base-plugin
   dep_of = "dependent-plugin.nvim"  -- Load before dependent-plugin
   ```

### Special Cases

**Plugins with after directories (like cmp sources):**
```lua
return {
  "cmp-source.nvim",
  event = "InsertEnter",
  load = function(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd(name .. "/after")
  end,
}
```

**Plugins that need initialization before loading:**
```lua
return {
  "plugin-name.nvim",
  event = "VimEnter",
  before = function()
    -- Set variables or do initialization
    vim.g.plugin_name_setting = "value"
  end,
  after = function()
    require("plugin-name").setup({})
  end,
}
```

## Directory Structure

```
lua/
├── lze_specs/          # New: lze plugin specifications
│   ├── init.lua        # Main specs file that imports all others
│   ├── flash.lua       # Example: flash.nvim spec
│   ├── bufferline.lua  # Example: bufferline.nvim spec
│   ├── gitsigns.lua    # Example: gitsigns.nvim spec
│   ├── which-key.lua   # Example: which-key.nvim spec
│   └── templates.lua   # Template examples for conversion
├── lze_config.lua      # New: lze configuration loader
├── plugins/            # Old: Manual plugin configs (to be migrated)
└── ...
```

## Migration Steps for Remaining Plugins

1. **Create a new spec file** in `lua/lze_specs/` named after the plugin
2. **Convert the plugin configuration** using the patterns above
3. **Add the spec to `lua/lze_specs/init.lua`**
4. **Test the configuration** to ensure the plugin loads correctly
5. **Remove the old plugin file** from `lua/plugins/` once confirmed working

## Benefits of Using lze

1. **Better Performance** - Plugins load only when needed
2. **Cleaner Code** - No manual `packadd` calls scattered throughout
3. **Flexible Loading** - Multiple trigger types (events, keys, commands, etc.)
4. **Dependency Management** - Load plugins before/after other plugins
5. **Consistent Structure** - All plugin configs follow the same pattern

## Testing

After making changes, test your configuration:

1. Build the flake: `nix build`
2. Run neovim: `./result/bin/nvim`
3. Check that plugins load correctly using the intended triggers
4. Monitor startup time improvements

## Troubleshooting

If a plugin doesn't load as expected:

1. Check the lze spec for correct trigger conditions
2. Ensure the plugin name matches the nix package name
3. Verify the plugin is in the `optionalPlugins` category in flake.nix
4. Check for any errors in the Neovim messages
5. Use `:checkhealth` to verify plugin availability