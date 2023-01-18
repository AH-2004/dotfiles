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
(global-display-line-numbers-mode t)
(setq user-dialog-box nil)

;; Window size
(when window-system (set-frame-size (selected-frame) 80 24))

;; Editing Tweaks
(setq-default tab-width 4)
(electric-pair-mode t)

;; CUA
(cua-mode t)
(setq cua-keep-region-after-copy nil)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'tron-legacy t)
