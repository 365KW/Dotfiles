;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:

;; Personal Emacs configuration.
;; Package management handled by Elpaca (see early-init.el).

;;; Code:

(setq use-package-always-ensure t)

;; Explicit dependencies (must be installed before dependent packages)
(elpaca compat)
(elpaca transient)

;; ── UI ──────────────────────────────────────────────────
(global-display-line-numbers-mode t)
(global-hl-line-mode 1)
(setq initial-scratch-message nil)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :family "Cascadia Code NF" :height 125)

;; ── Discord Integration ─────────────────────────────────

(use-package elcord
  :config (elcord-mode))

;; ── Completion ──────────────────────────────────────────

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.4)
  (corfu-cycle t)
  (corfu-on-exact-match nil)
  :config
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package cape
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package vertico
  :config (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :config (marginalia-mode))

;; ── Linting ─────────────────────────────────────────────

(use-package eglot
  :ensure nil
  :custom
  (eglot-autoshutdown t)
  :hook
  ((c-mode . eglot-ensure)
   (c-ts-mode . eglot-ensure)
   (c++-mode . eglot-ensure)
   (c++-ts-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (python-ts-mode . eglot-ensure)
   (rust-mode . eglot-ensure)
   (rust-ts-mode . eglot-ensure)
   (go-mode . eglot-ensure)
   (go-ts-mode . eglot-ensure)
   (typescript-ts-mode . eglot-ensure)
   (tsx-ts-mode . eglot-ensure)
   (javascript-mode . eglot-ensure)
   (sh-mode . eglot-ensure)
   (java-mode . eglot-ensure)
   (lisp-mode . eglot-ensure)))

(use-package flymake
  :ensure nil
  :custom
  (flymake-fringe-indicators t))

;;(use-package eglot-jdtls
;;  :ensure nil)

;; ── Formatting  ─────────────────────────────────────────

(use-package apheleia
  :config (apheleia-global-mode +1))

(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config (treesit-auto-add-to-auto-mode-alist 'all)
  :hook (after-init . global-treesit-auto-mode))

(electric-pair-mode 1)

;; ── Experience ──────────────────────────────────────────

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)))

(use-package treemacs
  :bind ("C-x t t" . treemacs)
  :config
  (treemacs-resize-icons 16))
;; ── Search & Replace ───────────────────────────────────

(use-package visual-regexp
  :bind (("C-c r" . vr/replace)
         ("C-c q" . vr/query-replace)))

(use-package visual-regexp-steroids)

;; ── Persistence ────────────────────────────────────────

(savehist-mode 1)
(save-place-mode 1)

;; ── Electric Pair ──────────────────────────────────────

(electric-pair-mode 1)

;; ── Org-mode ───────────────────────────────────────────

(use-package org
  :ensure nil
  :config
  (setq org-startup-indented t)
  (setq org-hide-leading-stars t)
  (setq org-adapt-indentation nil)
  (setq org-latex-packages '(("margin" "geometry")))
  (add-to-list 'org-latex-packages '("" "amsmath" t))
  (add-to-list 'org-latex-packages '("" "amssymb" t))
  (setq org-preview-latex-default-process 'dvipng)
  :config
  )

;; ── LaTeX / AUCTeX ─────────────────────────────────────

(use-package auctex
  ;;  :elpaca (:host github :repo "immerrr/auctex")
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-PDF-mode t)
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-view-program-list '(("Evince" "evince %o")))
  (setq TeX-view-program-selection '((output-pdf "Evince")))
  (setq LaTeX-enable-preview t)
  (setq LaTeX-preview-default-process 'dvipng)
  :hook
  ((LaTeX-mode . TeX-source-correlate-mode)
   (LaTeX-mode . prettify-symbols-mode)))

;; ── Markdown + LaTeX ────────────────────

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :config
  (setq markdown-enable-math t)
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-header-scaling t))

(use-package math-preview
  :bind (:map markdown-mode-map
              ("C-c m p" . math-preview-all)
              ("C-c m c" . math-preview-clear-all)))

;; ── Modeline ───────────────────────────────────────────

(use-package doom-modeline
  :config (doom-modeline-mode 1))

;; ── Git ─────────────────────────────────────────────────

(use-package magit
  :bind ("C-x g" . magit-status))

;; ── Project Management ──────────────────────────────────

(use-package projectile
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/projects" "~/code")))

;; ── Debugging ───────────────────────────────────────────

;;(use-package dap-mode
;;  :ensure (:host github :repo "emacs-lsp/dap-mode" :main "dap-mode.el")
;;  :config
;;  (require 'dap-cpptools)
;;  (require 'dap-lldb)
;;  (require 'dap-gdb-lldb))

(use-package dape
  :config
  (add-to-list 'dape-configs
               '(debugpy
                 modes (python-mode python-ts-mode)
                 command "debugpy"
                 command-args ("adapter" "--host" "127.0.0.1" "--port" "5678")
                 :process dape-start-process)))

;; ── UI Enhancement ──────────────────────────────────────

(use-package which-key
  :ensure nil
  :config (which-key-mode))

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; ── Snippets ────────────────────────────────────────────

(use-package yasnippet
  :config (yas-reload-all)
  :hook ((prog-mode org-mode) . yas-minor-mode))


;; ── Theme ───────────────────────────────────────────────

(use-package catppuccin-theme
  :config (load-theme 'catppuccin :no-confirm))
;; Load theme in daemon launching
(add-hook 'after-make-frame-functions
          (lambda (_frame)
            (load-theme 'catppuccin :no-confirm)))

;;; init.el ends here
(put 'upcase-region 'disabled nil)
