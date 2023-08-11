(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Icons
(use-package all-the-icons
  :config
  (setq all-the-icons-color-icons nil)
  (setq all-the-icons-scale-factor 1.0))

;; Sidebars
(use-package treemacs
  :disabled t
  :config
  (setq treemacs-width-is-locked nil)
  (setq treemacs-width-is-initially-locked nil)
  (setq treemacs-width 28)
  (setq treemacs-show-hidden-files t)
  (setq treemacs-is-never-other-window t)
  (load-file (concat custom-theme-directory "treemacs-all-the-icons.el"))
  (treemacs-load-theme "all-the-icons")
  (treemacs-follow-mode t)
  (treemacs-project-follow-mode t)
  (treemacs-filewatch-mode t))

(use-package neotree
  :config
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 28)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (setq neo-autorefresh t)
  (setq neo-show-hidden-files t)
  (setq neo-show-updir-line nil)
  (setq neo-show-slash-for-folder nil)
  (setq neo-hide-cursor t)
  (setq neo-mode-line-type 'none))

;; Completions
(use-package corfu
  :config
  (setq corfu-auto t)
  (setq corfu-cycle t)
  (setq corfu-auto-delay 0)
  (setq corfu-min-width 40)
  (setq corfu-max-width corfu-min-width)
  (setq corfu-scroll-margin 4)
  :init
  (global-corfu-mode))

;; (use-package kind-icon
;;   :after corfu
;;   :custom
;;   (kind-icon-blend-background nil)
;;   (kind-icon-default-face 'corfu-default)
;;   :config
;;   (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package lsp-mode
  :disabled t
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-diagnostics-provider :none)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-lens-enable nil)
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-enable-snippet nil))

(use-package eglot
  :config
  (setq eglot-autoshutdown t)
  (add-to-list 'eglot-stay-out-of 'flymake))

;; Terminal
(use-package vterm
  :config
  (setq vterm-kill-buffer-on-exit t)
  (setq vterm-buffer-name-string "vterm")
  (setq vterm-tramp-shells '(("docker" "/usr/bin/bash") ("ssh" "/usr/bin/bash"))))

;; Openwith
(use-package openwith
  :config
  (setq openwith-associations '(("\\.pdf\\'" "zathura" (file))))
  :init
  (openwith-mode t))

(use-package emms
  :config
  (setq emms-player-list '(emms-player-mpv))
  (setq emms-info-functions '(emms-info-native))
  (setq emms-playlist-buffer-name "*Emms*")
  (emms-mode-line -1)
  (emms-playing-time -1)
  :init
  (emms-all))

;; Others
(use-package format-all)
(use-package lua-mode)
(use-package buffer-move)
(use-package adaptive-wrap)
(use-package all-the-icons-dired)
(use-package base16-theme)
(use-package drag-stuff)
(use-package good-scroll :init (good-scroll-mode))
(use-package lorem-ipsum)
(use-package multi-vterm)
(use-package org-autolist)
(use-package org-modern)
(use-package rainbow-mode)
(use-package sudo-edit)
(use-package vertico :init (vertico-mode))
(use-package savehist :init (savehist-mode))
