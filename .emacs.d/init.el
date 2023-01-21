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

;; Window size
(when window-system (set-frame-size (selected-frame) 160 45))

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

;; Sidebar

;; Treemacs
(use-package treemacs
  :config
  (progn
	(setq treemacs-is-never-other-window t)
	(setq treemacs-width-is-locked nil)
	(setq treemacs-width-is-initially-locked nil)
  )
  (treemacs-resize-icons 16)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-project-follow-mode t)
)
(with-eval-after-load 'treemacs (define-key treemacs-mode-map [mouse-1] 'treemacs-single-click-expand-action))

;; Neotree
(setq neo-window-fixed-size nil)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)
(setq neo-show-hidden-files t)
(setq neo-hide-cursor t)
(setq neo-autorefresh t)

;; Keybindings

(global-set-key (kbd "C-K") 'neotree-toggle)
;; (global-set-key (kbd "C-K") 'treemacs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(projectile all-the-icons neotree treemacs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
