(defun init ()
  (message (emacs-init-time))
  (find-file "~/.emacs.d/*notes*")
  (cd "~")
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
)

;; Require packages
(require 'package)
(require 'org)
(require 'dired)
(require 'use-package)
(require 'use-package-ensure)
(require 'windmove)

(load "~/.emacs.d/packages.el")

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(setq user-dialog-box nil)
(setq frame-title-format '("Emacs " emacs-version))
(setq ring-bell-function 'ignore)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(setq org-image-actual-width nil)
(add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))
(defadvice split-window (after split-window-after activate) (other-window 1))

(setq-default
 mode-line-format
 (list
  mode-line-front-space
  "%b"
  mode-line-front-space
  mode-line-modified
  mode-line-front-space
  "L%l"
  mode-line-front-space
  "%I"
  mode-line-front-space
  mode-line-modes
  ))

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'default-frame-alist '(font . "IBM Plex Mono 10"))
(load-theme 'base16-chalk t)

;; Other tweaks
(add-to-list 'exec-path "~/.local/bin")
(setq custom-file "~/.emacs.d/custom.el")
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq inhibit-startup-message t)
(setq frame-resize-pixelwise t)
(setq use-package-always-ensure t)
(setq python-indent-guess-indent-offset-verbose nil)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq browse-url-browser-function 'browse-url-xdg-open)
(setq dired-kill-when-opening-new-dired-buffer t)
(setq dired-listing-switches "-lah --group-directories-first")
(global-auto-revert-mode t)

;; Editing Tweaks
(setq-default tab-width 4)
(setq-default c-basic-offset tab-width)
(setq-default python-indent-offset tab-width)
(electric-pair-mode t)
(setq org-support-shift-select t)
(setq org-replace-disputed-keys t)
(setq org-return-follows-link t)

(load "~/.emacs.d/hooks.el")
(load "~/.emacs.d/functions.el")
(load "~/.emacs.d/keybindings.el")

;; Aliases
(defalias 'checkbox 'org-toggle-checkbox)
(defalias 'save 'save-buffer)
(defalias 'term 'multi-vterm)
