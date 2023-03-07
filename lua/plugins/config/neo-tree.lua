-- remove deprecated commands
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local ok, neo_tree = pcall(require, "neo-tree")
if not ok then
  return
end

neo_tree.setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  default_component_configs = {
    icon = {
      folder_empty = "",
      default = "",
    },
  },
  sources = {
    "filesystem",
    "buffers",
    "git_status",
  },
  window = {
    position = "left",
    width = 40,
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      -- ["s"] = "open_split",
      -- ["v"] = "open_vsplit",
      ["s"] = "split_with_window_picker",
      ["v"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["Z"] = "expand_all_nodes",
      ["a"] = {
        "add",
        config = {
          show_path = "relative",
        },
      },
      ["A"] = {
        "add_directory",
        config = {
          show_path = "relative",
        },
      },
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = {
        "copy",
        config = {
          show_path = "relative",
        },
      },
      ["m"] = {
        "move",
        config = {
          show_path = "relative",
        },
      },
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_by_name = {
        "node_modules",
      },
      hide_by_pattern = { -- uses glob style patterns
        -- "*.meta",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      },
    },
  },
  buffers = {
    follow_current_file = true, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },

  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        neo_tree.close_all()
      end,
    },
  },
})

-- Keymaps
require("core.utils").keymap("n", "\\", ":Neotree toggle reveal<cr>", {})
