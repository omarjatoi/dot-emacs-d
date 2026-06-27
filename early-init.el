;;; early-init.el --- Loaded before the UI and package system -*- lexical-binding: t; -*-
;;; Commentary:
;; Runs before init.el and before any frame is drawn.  Disabling UI chrome
;; here (via `default-frame-alist') avoids the toolbar/scrollbar flashing on
;; startup, which is what you get if you do it in init.el.
;;; Code:

;; We manage packages with straight.el, so stop package.el from initializing.
(setq package-enable-at-startup nil)

;; Raise the GC threshold during startup for a faster init, then drop it back
;; to a sane runtime value once we're up.
(setq gc-cons-threshold (* 64 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

;; Don't create UI chrome at all (flash-free), rather than removing it later.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Avoid the implied frame resize when fonts/menus change at startup.
(setq frame-inhibit-implied-resize t)

(provide 'early-init)
;;; early-init.el ends here
