-- Tailwind CSS LSP configuration.
-- Provides class name completions, linting, and hover previews.
-- The server auto-detects tailwind.config.{js,ts,mjs,cjs} in your project root.
--
-- Add filetypes below if you use other frameworks (svelte, vue, astro, mdx, etc.).

return {
  filetypes = {
    'html',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  settings = {
    tailwindCSS = {
      -- Which HTML attributes to check for Tailwind classes.
      -- Covers React (className), Vue (:class), Angular (ngClass), etc.
      classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
      lint = {
        cssConflict = 'warning',
        invalidApply = 'warning',
        invalidConfigPath = 'error',
        invalidScreen = 'warning',
        invalidTailwindDirective = 'error',
        invalidVariant = 'warning',
        recommendedVariantOrder = 'warning',
      },
      validate = 'warning',
    },
  },
}
