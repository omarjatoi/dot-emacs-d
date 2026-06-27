;;; editing.el --- Editing, files, and persistence -*- lexical-binding: t; -*-
;;; Commentary:
;; Indentation, backup/lock/auto-save file handling, the custom-file, and
;; minibuffer history persistence.
;;; Code:

;; Tabs: 4-wide, spaces only.
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Don't scatter lockfiles (.#foo) next to the files we edit.
(setq create-lockfiles nil)

;; Keep backups (foo~) and auto-saves (#foo#) out of the working directory.
(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-save-dir (expand-file-name "auto-saves/" user-emacs-directory)))
  (make-directory backup-dir t)
  (make-directory auto-save-dir t)
  (setq backup-directory-alist `((".*" . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-save-dir t))))

;; Keep `customize' output in its own file instead of appending to init.el.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

;; Persist minibuffer history across sessions (built-in; no install needed).
(use-package savehist
  :straight nil
  :init
  (savehist-mode))

(provide 'editing)
;;; editing.el ends here
