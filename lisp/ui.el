;;; ui.el --- Appearance and look-and-feel -*- lexical-binding: t; -*-
;;; Commentary:
;; Theme, font, line numbers, scrolling, and general visual tweaks.
;;; Code:

;; Quieter, cleaner startup.
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(blink-cursor-mode -1)

;; The font to use.
(set-frame-font "JetBrains Mono 14" nil t)

;; Theme.  See https://github.com/motform/stimmung-themes
(use-package stimmung-themes
  :config
  (load-theme 'stimmung-themes-light t))

;; Line numbers only in programming buffers; highlight the current line.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(global-hl-line-mode 1)

;; Scrolling: page up/down moves to buffer edges instead of erroring, and use
;; precise (pixel) trackpad scrolling on Emacs 29+.
(setq scroll-error-top-bottom t)
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

(provide 'ui)
;;; ui.el ends here
