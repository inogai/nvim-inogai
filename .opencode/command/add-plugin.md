---
description: Add a Neovim plugin to nixCats configuration
agent: general
---

I need to add the Neovim plugin "$1" to this nixCats configuration. Please follow these comprehensive steps:

## 1. Search for Plugin in nixpkgs

First, check if the plugin is available in nixpkgs using these commands:

```bash
nix search nixpkgs neovimPlugins.$1
nix search nixpkgs vimPlugins.$1
```

## 2. Determine Plugin Source

- **If found in nixpkgs**: Use the nixpkgs version (preferred for stability)
- **If not found**: Find the GitHub repository and use it as a git plugin

For GitHub plugins, search with: `!`gh search repos "$1" language:lua`

## 3. Update flake.nix

### For GitHub plugins:

Add to the `inputs` section (around line 24-38):

```nix
"plugins-$1" = {
  url = "github:USER/REPO";
  flake = false;
};
```

### Add to optionalPlugins:

- **GitHub plugins**: Add to `optionalPlugins.gitPlugins` (line 207-210)
- **nixpkgs plugins**: Add to `optionalPlugins.general` (line 211-258)

Example placement:

```nix
optionalPlugins = {
  gitPlugins = with pkgs.neovimPlugins; [
    # existing plugins...
    $1  # Add GitHub plugin here
  ];
  general = with pkgs.vimPlugins; [
    # existing plugins...
    $1  # Add nixpkgs plugin here
  ];
};
```

## 4. Create Plugin Configuration

### ⚠️ **CRITICAL: File Naming Convention**

**For plugins with dots in names (e.g., `leetcode.nvim`):**
- Create directory: `lua/lze_specs/plugin-name/init.lua`
- Use in import: `'lze_specs.plugin-name'`

**For plugins without dots:**
- Create file: `lua/lze_specs/plugin-name.lua`
- Use in import: `'lze_specs.plugin-name'`

### Basic Plugin Template:

```lua
return {
  {
    '$1',
    -- Loading strategy: 'event', 'cmd', 'keys', 'ft', or 'VimEnter'
    event = 'VimEnter',  -- or: cmd = 'CommandName', keys = '<leader>key'
    config = function()
      require('$1').setup({
        -- Plugin configuration options here
      })
    end,
  },
}
```

### LSP Plugin Example:

```lua
return {
  {
    '$1',
    ft = { 'filetype1', 'filetype2' },
    config = function()
      require('$1').setup({
        -- LSP-specific config
      })
    end,
  },
}
```

### UI Plugin Example:

```lua
return {
  {
    '$1',
    event = 'VeryLazy',
    config = function()
      require('$1').setup({
        -- UI-specific config
      })
    end,
  },
}
```

### Completion Plugin Example:

```lua
return {
  {
    '$1',
    event = 'InsertEnter',
    dependencies = { 'other-plugin' },
    config = function()
      require('$1').setup({})
    end,
  },
}
```

### Git Plugin Example:

```lua
return {
  {
    '$1',
    event = 'BufReadPre',
    config = function()
      require('$1').setup({})
    end,
  },
}
```

### Utility Plugin Example:

```lua
return {
  {
    '$1',
    cmd = { 'Command1', 'Command2' },
    keys = { '<leader>key' },
    config = function()
      require('$1').setup({})
    end,
  },
}
```

## 5. Update LZE Init File

Add `{ import = 'lze_specs.$1' }` to `lua/lze_specs/init.lua` (maintain alphabetical order)

## 6. Verification Steps

### Stage 1: Build Verification
```bash
# Rebuild configuration
nix build .#nvim-inogai
```

### Stage 2: LZE Spec Loading
```bash
# Test LZE spec loads without error
./result/bin/nvim-inogai --headless -c "lua require('lze_specs.$1')" -c "qa"
```

### Stage 3: Plugin Module Loading
```bash
# Test plugin can be loaded (for lazy-loaded plugins)
./result/bin/nvim-inogai --headless -c "lua require('lze_specs.$1')" -c "lua vim.cmd('packadd $1')" -c "lua require('$1')" -c "qa"
```

### Stage 4: Command/Functionality Testing
```bash
# Test plugin commands (may fail in headless mode for UI plugins)
./result/bin/nvim-inogai --headless -c "lua require('lze_specs.$1')" -c ":CommandName" -c "qa" 2>&1 | head -5
```

## 7. Plugin Name Verification

### Verify Actual Plugin Name
```bash
# Check the actual plugin name in nixpkgs
nix-instantiate --eval --expr 'let pkgs = import <nixpkgs> {}; in pkgs.vimPlugins.$1.name'
```

### Check Plugin Structure
```bash
# Verify plugin is in pack directory
find result -name "*$1*" -type f

# Check dependencies are available
find "/nix/store/...-vim-pack-dir/pack/myNeovimPackages/start/" -name "*dependency*"
```

## 8. Common Issues and Solutions

### 🔴 **Module Not Found Errors**
- **Problem**: `module 'lze_specs.plugin.name' not found`
- **Solution**: Use directory structure for plugins with dots: `plugin-name/init.lua`

### 🔴 **Plugin Name Mismatch**
- **Problem**: Plugin doesn't load despite correct setup
- **Solution**: Verify actual plugin name with `nix-instantiate --eval` command

### 🔴 **Headless Mode UI Errors**
- **Problem**: UI plugins throw errors in headless testing
- **Solution**: This is expected - focus on module loading, not UI functionality

### 🔴 **Missing Dependencies**
- **Problem**: Plugin loads but dependencies missing
- **Solution**: Check pack directory structure and add explicit dependencies to LZE spec

### 🔴 **Command Not Found**
- **Problem**: `Command 'X' not found after loading`
- **Solution**: Plugin may need manual `packadd` or different loading strategy

## 9. Testing Strategies

### For UI Plugins:
```bash
# Test module loading only
./result/bin/nvim-inogai --headless -c "lua require('lze_specs.$1')" -c "lua vim.cmd('packadd $1')" -c "lua local mod = require('$1'); print('✓ Plugin loaded successfully')" -c "qa"
```

### For Command-based Plugins:
```bash
# Test command availability
./result/bin/nvim-inogai --headless -c "lua require('lze_specs.$1')" -c "lua vim.cmd('packadd $1')" -c "lua print('Available commands:', vim.tbl_keys(vim.api.nvim_get_commands({})))" -c "qa"
```

### For LSP Plugins:
```bash
# Test LSP client setup
./result/bin/nvim-inogai --headless -c "lua require('lze_specs.$1')" -c "lua print('LSP servers:', vim.tbl_keys(vim.lsp.get_active_clients()))" -c "qa"
```

## Plugin name: $1

Additional arguments: $ARGUMENTS

## Current Configuration Structure:

@flake.nix

@lua/lze_specs/init.lua

## Reference Examples:

@lua/lze_specs/triforce.lua
@lua/lze_specs/flash.lua
@lua/lze_specs/blink-cmp.lua

## Troubleshooting Checklist:

- [ ] Plugin name verified with `nix-instantiate --eval`
- [ ] Correct file naming convention used (directory for dots)
- [ ] Plugin added to correct section in `flake.nix`
- [ ] LZE spec created with proper plugin name
- [ ] Import added to `lua/lze_specs/init.lua` in alphabetical order
- [ ] Build succeeds without errors
- [ ] LZE spec loads without errors
- [ ] Plugin module can be required
- [ ] Dependencies are available in pack directory
- [ ] Commands/functions work as expected (if testable in headless mode)

## Advanced Debugging:

### Check Pack Directory Structure:
```bash
# List all plugins in pack directory
find result -path "*/pack/*" -name "*" | sort

# Check specific plugin structure
find result -name "*$1*" -exec ls -la {} \;
```

### Verify Runtime Path:
```bash
# Check if plugin is in runtimepath
./result/bin/nvim-inogai --headless -c "lua print('Runtimepath:', vim.opt.runtimepath:get())" -c "qa" | grep -o "$1"
```

### Debug LZE Loading:
```bash
# Check LZE loaded plugins
./result/bin/nvim-inogai --headless -c "lua print('LZE loaded:', package.loaded['lze'] ~= nil)" -c "qa"
```