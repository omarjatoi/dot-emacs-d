;;; macos.el --- macOS-specific configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Modifier keys, inheriting the shell PATH, and dired behaviour on macOS.
;;; Code:

;; Map the macOS modifier keys.
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; GUI Emacs on macOS doesn't inherit the shell's PATH (it's launched by the
;; window server, not a login shell), so tools like git/formatters/LSP can't be
;; found.  Pull the environment in from the shell.
(use-package exec-path-from-shell
  :init
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;; macOS `ls' doesn't support the `--dired' flag, which dired would otherwise
;; pass and warn about.
(setq dired-use-ls-dired nil)

(provide 'macos)
;;; macos.el ends here
