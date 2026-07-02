---@module 'lazy'
---@type LazySpec
return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  opts = {
    settings = {
      tsserver_plugins = {},
      tsserver_max_memory = 'auto',
      tsserver_locale = 'en',
      complete_function_calls = true,
      include_completions_with_insert_text = true,
      code_lens = 'off',
      disable_member_code_lens = true,
      jsx_close_tag = {
        enable = true,
        filetypes = { 'typescriptreact', 'javascriptreact' },
      },
      tsserver_file_preferences = {
        includeInlayParameterNameHints = 'literals',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        quotePreference = 'auto',
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeAutomaticOptionalChainCompletions = true,
        includeCompletionsWithInsertText = true,
        includePackageJsonAutoImports = 'auto',
      },
      tsserver_format_options = {
        indentSize = vim.o.shiftwidth,
        tabSize = vim.o.tabstop,
        convertTabsToSpaces = vim.o.expandtab,
        trimTrailingWhitespaceOnSave = true,
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
        semicolons = 'ignore',
      },
    },
  },
}
