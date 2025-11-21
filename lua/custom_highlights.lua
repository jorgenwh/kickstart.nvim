-- Centralized syntax highlighting configuration
-- Edit colors here and they will apply to both treesitter and LSP semantic tokens
--
-- HOW TO USE:
-- 1. Edit M.colors table below to change colors
-- 2. Set M.enabled to false to disable custom highlights
-- 3. Reload Neovim - changes apply automatically
-- 4. No need to edit multiple files - everything is here!

local M = {}

-- ============================================================================
-- ENABLE/DISABLE CUSTOM HIGHLIGHTS
-- ============================================================================
M.enabled = true -- Set to false to disable all custom syntax highlighting

-- ============================================================================
-- COLOR DEFINITIONS - Edit these to change syntax highlighting colors
-- ============================================================================
M.colors = {
  -- Core syntax
  functions = "#61afef",  -- blue - function/method names
  variables = "#e6e6e6",  -- white - local vars, member vars
  types = "#e5c07b",      -- yellow - type names, classes
  keywords = "#c678dd",   -- purple - if, for, return, class, def
  namespaces = "#56b6c2", -- cyan - std::, modules
  parameters = "#d19a66", -- orange - function parameters
  enums = "#d19a66",      -- orange - enum members, constants

  -- Literals
  strings = "#98c379",    -- green - "hello", 'world'
  numbers = "#d19a66",    -- orange - 42, 3.14, 0xFF
  booleans = "#d19a66",   -- orange - true, false, True, False

  -- Other
  comments = "#5c6370",   -- gray - // comment, # comment
  operators = "#c678dd",  -- purple - +, -, *, /, =, ==
  punctuation = "#abb2bf", -- light gray - (), {}, [], ;

  -- Language-specific
  decorators = "#e5c07b", -- yellow - @decorator (Python)
  preprocessor = "#c678dd", -- purple - #include, #define (C++)
  macros = "#56b6c2",     -- cyan - MACRO_NAME (C++)
}

-- ============================================================================
-- HIGHLIGHT APPLICATION - Applied automatically, don't edit unless adding new groups
-- ============================================================================
function M.apply()
  -- Early exit if custom highlights are disabled
  if not M.enabled then
    return
  end

  -- FUNCTIONS AND METHODS (green)
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

  -- ENUM MEMBERS / CONSTANTS (orange)
  -- Affects: enum member values
  -- Examples: MyEnum::Value1, Color::RED, Status::SUCCESS
  vim.api.nvim_set_hl(0, "@constant", { fg = M.colors.enums })                    -- constants including enum members
  vim.api.nvim_set_hl(0, "@constant.builtin", { fg = M.colors.enums })            -- None, NULL, nullptr

  -- LSP semantic tokens for enum members
  vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { fg = M.colors.enums })         -- LSP: enum member values

  -- STRINGS (green)
  -- Affects: string literals, character literals
  -- Examples: "hello", 'c', """docstring""", f"formatted"
  vim.api.nvim_set_hl(0, "@string", { fg = M.colors.strings })                    -- string literals
  vim.api.nvim_set_hl(0, "@string.escape", { fg = M.colors.strings })             -- escape sequences: \n, \t
  vim.api.nvim_set_hl(0, "@string.special", { fg = M.colors.strings })            -- special strings
  vim.api.nvim_set_hl(0, "@character", { fg = M.colors.strings })                 -- character literals: 'a'

  -- NUMBERS (orange)
  -- Affects: numeric literals
  -- Examples: 42, 3.14, 0xFF, 1e-5
  vim.api.nvim_set_hl(0, "@number", { fg = M.colors.numbers })                    -- all numbers
  vim.api.nvim_set_hl(0, "@number.float", { fg = M.colors.numbers })              -- floats: 3.14
  vim.api.nvim_set_hl(0, "@float", { fg = M.colors.numbers })                     -- floats (older form)

  -- BOOLEANS (orange)
  -- Affects: boolean literals
  -- Examples: true, false, True, False
  vim.api.nvim_set_hl(0, "@boolean", { fg = M.colors.booleans })                  -- true, false

  -- COMMENTS (gray)
  -- Affects: all comment types
  -- Examples: // line comment, /* block */, # Python comment, /// doc comment
  vim.api.nvim_set_hl(0, "@comment", { fg = M.colors.comments })                  -- all comments
  vim.api.nvim_set_hl(0, "@comment.documentation", { fg = M.colors.comments })    -- doc comments
  vim.api.nvim_set_hl(0, "Comment", { fg = M.colors.comments })                   -- base comment group

  -- OPERATORS (purple)
  -- Affects: arithmetic, logical, comparison operators
  -- Examples: +, -, *, /, =, ==, !=, &&, ||, <<, >>
  vim.api.nvim_set_hl(0, "@operator", { fg = M.colors.operators })                -- all operators

  -- PUNCTUATION (light gray)
  -- Affects: brackets, delimiters
  -- Examples: (), {}, [], ;, ,, ::
  vim.api.nvim_set_hl(0, "@punctuation", { fg = M.colors.punctuation })           -- general punctuation
  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = M.colors.punctuation })   -- (), {}, []
  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = M.colors.punctuation }) -- ;, ,
  vim.api.nvim_set_hl(0, "@punctuation.special", { fg = M.colors.punctuation })   -- special punctuation

  -- PYTHON-SPECIFIC
  -- Decorators: @property, @staticmethod, @my_decorator
  vim.api.nvim_set_hl(0, "@attribute", { fg = M.colors.decorators })              -- decorators
  vim.api.nvim_set_hl(0, "@attribute.python", { fg = M.colors.decorators })       -- Python decorators
  vim.api.nvim_set_hl(0, "@function.decorator", { fg = M.colors.decorators })     -- decorator functions

  -- C/C++-SPECIFIC
  -- Preprocessor: #include, #define, #ifdef
  vim.api.nvim_set_hl(0, "@keyword.directive", { fg = M.colors.preprocessor })    -- preprocessor directives
  vim.api.nvim_set_hl(0, "@preproc", { fg = M.colors.preprocessor })              -- preprocessor (older form)
  vim.api.nvim_set_hl(0, "@define", { fg = M.colors.preprocessor })               -- #define
  vim.api.nvim_set_hl(0, "@include", { fg = M.colors.preprocessor })              -- #include

  -- Macros: MY_MACRO, SOME_CONSTANT
  vim.api.nvim_set_hl(0, "@constant.macro", { fg = M.colors.macros })             -- macro constants
  vim.api.nvim_set_hl(0, "@function.macro", { fg = M.colors.macros })             -- macro functions
  vim.api.nvim_set_hl(0, "@lsp.type.macro", { fg = M.colors.macros })             -- LSP: macros

  -- Clear any LSP modifiers that might override our colors
  vim.api.nvim_set_hl(0, "@lsp.mod.declaration", {})
end

return M
