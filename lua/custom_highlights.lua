-- Centralized syntax highlighting configuration
-- Edit colors here and they will apply to both treesitter and LSP semantic tokens
--
-- HOW TO USE:
-- 1. Edit M.colors table below to change colors
-- 2. Reload Neovim - changes apply automatically
-- 3. No need to edit multiple files - everything is here!

local M = {}

-- ============================================================================
-- COLOR DEFINITIONS - Edit these to change syntax highlighting colors
-- ============================================================================
M.colors = {
  functions = "#49e334",  -- red
  variables = "#e6e6e6",  -- white
  types = "#389fff",      -- blue
  keywords = "#f25555",   -- green
  namespaces = "#f0de78", -- yellow
  parameters = "#e6e6e6", -- white
  enums = "#e6e6e6",      -- white
}

-- ============================================================================
-- HIGHLIGHT APPLICATION - Applied automatically, don't edit unless adding new groups
-- ============================================================================
function M.apply()
  -- FUNCTIONS AND METHODS (red)
  -- Affects: function definitions, function calls, method calls, built-in functions, constructors
  -- Examples: myFunc(), obj.method(), std::move(), printf(), MyClass(), new MyClass()
  vim.api.nvim_set_hl(0, "@function", { fg = M.colors.functions })                -- function definitions: void myFunc() {}
  vim.api.nvim_set_hl(0, "@function.call", { fg = M.colors.functions })           -- function calls: myFunc()
  vim.api.nvim_set_hl(0, "@function.builtin", { fg = M.colors.functions })        -- built-in functions: std::move(), printf()
  vim.api.nvim_set_hl(0, "@function.method.call", { fg = M.colors.functions })    -- method calls: obj.value(), ptr->getValue()
  vim.api.nvim_set_hl(0, "@method", { fg = M.colors.functions })                  -- method definitions: void MyClass::method() {}
  vim.api.nvim_set_hl(0, "@method.call", { fg = M.colors.functions })             -- method calls (alternative form)
  vim.api.nvim_set_hl(0, "@constructor", { fg = M.colors.functions })             -- constructor calls: MyClass(), new MyClass()

  -- LSP semantic tokens for functions/methods (override treesitter when LSP is active)
  vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = M.colors.functions })       -- LSP: function definitions
  vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = M.colors.functions })         -- LSP: method definitions
  vim.api.nvim_set_hl(0, "@lsp.type.member", { fg = M.colors.functions })         -- LSP: member functions

  -- VARIABLES (white)
  -- Affects: local variables, member variables (m_foo), object properties (obj.field)
  -- Examples: int x = 5; m_count; obj.seamlessStatus; myInstance.relativeDelay
  vim.api.nvim_set_hl(0, "@variable", { fg = M.colors.variables })                -- all variables: int x; when using x later
  vim.api.nvim_set_hl(0, "@variable.member", { fg = M.colors.variables })         -- member variables: m_essenceTransportStatus, m_count
  vim.api.nvim_set_hl(0, "@property", { fg = M.colors.variables })                -- object properties: obj.relativeDelay, ptr->seamlessStatus

  -- LSP semantic tokens for variables (override treesitter when LSP is active)
  vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = M.colors.variables })       -- LSP: object properties
  vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = M.colors.variables })       -- LSP: all variables

  -- TYPES (red)
  -- Affects: type names (int, auto, MyClass, int32_t, std::string)
  -- Examples: int x; auto y = 5; MyClass obj; std::vector<int32_t> vec;
  vim.api.nvim_set_hl(0, "@type", { fg = M.colors.types })                        -- custom types: MyClass, MyStruct
  vim.api.nvim_set_hl(0, "@type.builtin", { fg = M.colors.types })                -- built-in types: int, auto, int32_t, size_t, void

  -- LSP semantic tokens for types (override treesitter when LSP is active)
  vim.api.nvim_set_hl(0, "@lsp.type.type", { fg = M.colors.types })               -- LSP: all type names

  -- KEYWORDS (green)
  -- Affects: control flow keywords (if, while, for, return, break, continue, switch, case)
  -- Examples: if (x > 0) { return true; } for (int i = 0; ...) while (running) { break; }
  vim.api.nvim_set_hl(0, "@keyword", { fg = M.colors.keywords })                  -- all keywords
  vim.api.nvim_set_hl(0, "@keyword.control", { fg = M.colors.keywords })          -- control flow: if, while, for, else
  vim.api.nvim_set_hl(0, "@keyword.return", { fg = M.colors.keywords })           -- return statements
  vim.api.nvim_set_hl(0, "@keyword.control.return", { fg = M.colors.keywords })   -- return (alternative form)
  vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = M.colors.keywords })           -- loops: for, while, do
  vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = M.colors.keywords })      -- conditionals: if, else, switch, case

  -- LSP semantic tokens for keywords (override treesitter when LSP is active)
  vim.api.nvim_set_hl(0, "@lsp.type.keyword", { fg = M.colors.keywords })         -- LSP: all keywords

  -- NAMESPACES (white)
  -- Affects: namespace names (std::, myNamespace::, using namespace)
  -- Examples: std::vector, myNamespace::MyClass, using namespace std;
  vim.api.nvim_set_hl(0, "@namespace", { fg = M.colors.namespaces })              -- namespace names
  vim.api.nvim_set_hl(0, "@module", { fg = M.colors.namespaces })                 -- module names (alternative form)

  -- LSP semantic tokens for namespaces
  vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = M.colors.namespaces })     -- LSP: namespace names

  -- PARAMETERS (white)
  -- Affects: function/method parameters in definitions and when used inside function body
  -- Examples: void func(int param1, std::string param2) { return param1 + param2.size(); }
  vim.api.nvim_set_hl(0, "@parameter", { fg = M.colors.parameters })              -- parameter definitions
  vim.api.nvim_set_hl(0, "@variable.parameter", { fg = M.colors.parameters })     -- parameter usage in function body

  -- LSP semantic tokens for parameters
  vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = M.colors.parameters })     -- LSP: function parameters

  -- ENUM MEMBERS (white)
  -- Affects: enum member values
  -- Examples: MyEnum::Value1, Color::RED, Status::SUCCESS
  vim.api.nvim_set_hl(0, "@constant", { fg = M.colors.enums })                    -- constants including enum members

  -- LSP semantic tokens for enum members
  vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { fg = M.colors.enums })         -- LSP: enum member values

  -- Clear any LSP modifiers that might override our colors
  vim.api.nvim_set_hl(0, "@lsp.mod.declaration", {})
end

return M
