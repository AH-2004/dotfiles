;; Startup
(setq inhibit-startup-message t)
(setq initial-buffer-choice nil)

;; Auto save and backup
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
;; (global-display-line-numbers-mode t)
(setq user-dialog-box nil)
(setq frame-title-format '("Emacs " emacs-version))
;; Editing Tweaks
(setq-default tab-width 4)
(electric-pair-mode t)

;; CUA
(cua-mode t)
(setq cua-keep-region-after-copy nil)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'tron-legacy t)
(load-theme 'dracula t)

;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Sidebar
(use-package treemacs)
(use-package neotree)

;; Treemacs
(use-package treemacs
  :config
  (setq treemacs-is-never-other-window t)
  (setq treemacs-width-is-locked nil)
  (setq treemacs-width-is-initally-locked nil)
  (treemacs-resize-icons 16)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-project-follow-mode t)
)
(with-eval-after-load 'treemacs (define-key treemacs-mode-map [mouse-1] 'treemacs-single-click-expand-action))

;; Neotree
(use-package neotree
  :config
  (setq neo-window-fixed-size nil)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (setq neo-show-hidden-files t)
  (setq neo-hide-cursor t)
  (setq neo-autorefresh t)
)

(use-package corfu
  :config
  (setq corfu-auto t)
)

;; Keybindings

;; Sidebar toggling
(global-set-key (kbd "C-K") 'treemacs)
;; (global-set-key (kbd "C-K") 'neotree-toggle)

;;Completions
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "C-SPC") 'dabbrev-expand)

(setq custom-file (concat user-emacs-directory "/custom.el"))
