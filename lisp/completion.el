;;; completion.el --- Minibuffer and in-buffer completion -*- lexical-binding: t; -*-
;;; Commentary:
;; The completion stack: vertico (minibuffer UI), orderless (matching),
;; marginalia (annotations), consult (search/navigation commands), corfu
;; (in-buffer popup completion), and prescient (frecency-based sorting).
;;; Code:

;; Vertical interactive completion in the minibuffer.
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-count 15)
  (setq vertico-resize t))

;; Path-aware navigation in the minibuffer (find-file etc.).  Ships with
;; vertico, so it's already on the load-path; just configure it.
;;   RET / C-j  enter the directory (or open the file)
;;   DEL        delete a char, or jump up a level when right after a "/"
;;   M-DEL      delete a whole path component -> go up a directory
(use-package vertico-directory
  :straight nil
  :after vertico
  :bind (:map vertico-map
         ("RET"   . vertico-directory-enter)
         ("C-j"   . vertico-directory-enter)
         ("DEL"   . vertico-directory-delete-char)
         ;; Go up one directory, regardless of cursor position.  M-DEL does the
         ;; same when point is right after a "/"; C-l is the dedicated key.
         ("M-DEL" . vertico-directory-delete-word)
         ("C-l"   . vertico-directory-delete-word))
  ;; Clean up the "shadowed" part of the path (e.g. when you type ~/ or /).
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;; Fuzzy, space-separated matching in any order.
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

;; Rich annotations (file sizes, docstrings, key bindings) in the minibuffer.
(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; Practical search and navigation commands built on the completion UI.
(use-package consult
  :bind (("C-s"   . consult-line)
         ("C-x b" . consult-buffer)
         ("M-y"   . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g i" . consult-imenu)
         ("M-s r" . consult-ripgrep)
         ("M-s f" . consult-find)))

;; In-buffer completion popup (code/text completion at point).
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-cycle t))

;; Sort candidates by frecency (frequency + recency) and persist that across
;; sessions.  Filtering is left to orderless; prescient only sorts.
(use-package prescient
  :config
  (prescient-persist-mode 1))

(use-package vertico-prescient
  :after (vertico prescient)
  :init
  (setq vertico-prescient-enable-filtering nil)
  (vertico-prescient-mode 1))

(use-package corfu-prescient
  :after (corfu prescient)
  :init
  (setq corfu-prescient-enable-filtering nil)
  (corfu-prescient-mode 1))

(provide 'completion)
;;; completion.el ends here
