;;; init.el --- Main entry point -*- lexical-binding: t; -*-
;;; Commentary:
;; Bootstraps straight.el + use-package, then loads the configuration modules
;; in lisp/.  Keep this file thin: feature config lives in the modules.
;;; Code:

;; --- Bootstrap straight.el -------------------------------------------------
;; See https://github.com/radian-software/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
;; Every `use-package' form installs via straight unless told otherwise, so we
;; can drop the per-package `:straight t'.
(setq straight-use-package-by-default t)

;; --- Load configuration modules --------------------------------------------
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'ui)
(require 'macos)
(require 'editing)
(require 'completion)

;;; init.el ends here
