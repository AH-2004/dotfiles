(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Icons
(use-package all-the-icons
  :config
  (setq all-the-icons-color-icons nil)
  (setq all-the-icons-scale-factor 1.0)  
)

;; Sidebars
(use-package treemacs
  :disabled t
  :config
  (progn
	(setq treemacs-is-never-other-window t)
	(setq treemacs-width-is-locked nil)
	(setq treemacs-width-is-initially-locked nil)
  )
  (treemacs-resize-icons 16)
  (treemacs-follow-mode t)
  (treemacs-project-follow-mode t)
  (treemacs-filewatch-mode t)  
  )

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map [mouse-1] 'treemacs-single-click-expand-action)
)

(use-package neotree
  :config
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 28)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (setq neo-show-hidden-files t)
  (setq neo-hide-cursor t)
  (setq neo-autorefresh t)
)

;; Completions
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-min-width 40)
  (corfu-max-width corfu-min-width)
  (corfu-scroll-margin 4)
  :init
  (global-corfu-mode)
)

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-blend-background nil)
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
)

(use-package lsp-mode
  :disabled t
  :init
  (setq lsp-auto-guess-root t)
  (setq lsp-diagnostics-provider :none)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-lens-enable nil)
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-enable-snippet nil)
)

;; Terminal
(use-package vterm
  :config
  (setq vterm-kill-buffer-on-exit t)
  (setq vterm-buffer-name-string "vterm")
)

;; Openwith
(use-package openwith
  :init
  (openwith-mode t)
  :config
  (setq openwith-associations '(("\\.pdf\\'" "zathura" (file))))
)

;; Others
(use-package adaptive-wrap)
(use-package all-the-icons-dired)
(use-package base16-theme)
(use-package drag-stuff)
(use-package eglot)
(use-package eldoc-box)
(use-package good-scroll :init (good-scroll-mode))
(use-package lorem-ipsum)
(use-package multi-vterm)
(use-package org-autolist)
(use-package org-modern)
(use-package rainbow-mode)
(use-package sudo-edit)
(use-package vertico :init (vertico-mode))
(use-package savehist :init (savehist-mode))
