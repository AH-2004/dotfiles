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

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)
(setq-default user-dialog-box nil)
(setq-default frame-title-format '("Emacs " emacs-version))
(setq-default ring-bell-function 'ignore)
(setq-default scroll-conservatively 1)
(setq-default auto-window-vscroll nil)
(setq-default auto-hscroll-mode nil)
(setq-default org-image-actual-width nil)
(add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))
(defadvice split-window (after split-window-after activate) (other-window 1))

;; Other tweaks
(add-to-list 'exec-path "~/.local/bin")
(setq-default custom-file "~/.emacs.d/custom.el")
(setq-default custom-theme-directory "~/.emacs.d/themes/")
(setq-default auto-save-default nil)
(setq-default make-backup-files nil)
(setq-default create-lockfiles nil)
(setq-default inhibit-startup-message t)
(setq-default inhibit-startup-echo-area-message t)
(setq-default initial-scratch-message nil)
(setq-default frame-resize-pixelwise t)
(setq-default use-package-always-ensure t)
(setq-default python-indent-guess-indent-offset-verbose nil)
(setq-default gc-cons-threshold 100000000)
(setq-default read-process-output-max (* 1024 1024))
(setq-default browse-url-browser-function 'browse-url-xdg-open)
(setq-default dired-kill-when-opening-new-dired-buffer t)
(setq-default dired-listing-switches "-lah --group-directories-first")
(setq-default completion-ignore-case t)
(setq-default global-auto-revert-mode t)
(setq-default read-file-name-completion-ignore-case t)
(setq-default read-buffer-completion-ignore-case t)
(setq-default initial-major-mode 'fundamental-mode)

;; Editing Tweaks
(electric-pair-mode t)
(setq-default tab-width 4)
(setq-default c-basic-offset tab-width)
(setq-default python-indent-offset tab-width)
(setq-default org-indent-indentation-per-level tab-width)
(setq-default org-edit-src-content-indentation tab-width)
(setq-default org-support-shift-select 'always)
(setq-default org-replace-disputed-keys t)
(setq-default org-return-follows-link t)
(setq-default org-adapt-indentation t)
(setq-default backward-delete-char-untabify-method nil)
(setq-default cua-keep-region-after-copy nil)

(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/functions.el")
(load "~/.emacs.d/hooks.el")
(load "~/.emacs.d/keybindings.el")

;; Theme
(add-to-list 'default-frame-alist '(font . "IBM Plex Mono 9"))
(load-theme 'base16-chalk t)

;; Modeline
(setq-default mode-line-format
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
	   mode-line-modes))

;; Aliases
(defalias 'checkbox 'org-toggle-checkbox)
(defalias 'save 'save-buffer)
(defalias 'term 'multi-vterm)
