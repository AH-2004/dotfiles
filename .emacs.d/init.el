;; Require packages
(require 'package)
(require 'org)
(require 'dired)
(require 'bookmark)
(require 'wdired)
(require 'use-package)
(require 'use-package-ensure)
(require 'windmove)
(require 'align)
(require 'cc-mode)

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(fringe-mode -1)
(setq-default use-dialog-box nil)
(setq-default use-file-dialog nil)
(setq-default frame-title-format '("Emacs " emacs-version))
(setq-default ring-bell-function 'ignore)
(setq-default scroll-conservatively 1)
(setq-default auto-window-vscroll nil)
(setq-default auto-hscroll-mode nil)
(setq-default org-image-actual-width (list 300))
(setq-default text-scale-mode-step 1.1)
;; (add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))
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
(setq-default large-file-warning-threshold nil)
(setq-default ediff-ignore-similar-regions t)
(setq-default ediff-highlight-all-diffs nil)

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
(setq-default org-indent-mode-turns-on-hiding-stars nil)
(setq-default backward-delete-char-untabify-method nil)
(setq-default cua-keep-region-after-copy nil)

(add-to-list 'align-rules-list
             '(c++-align
               (regexp . "[=;]\\(\\s-*\\)")
               (mode   . '(c++-mode))
               (repeat . t)))


(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/functions.el")
(load "~/.emacs.d/hooks.el")
(load "~/.emacs.d/keybindings.el")

;; Theme
(add-to-list 'default-frame-alist '(font . "IBM Plex Mono 10"))
(load-theme 'base16-tomorrow-night t)
;; (load-theme 'base16-ocean t)

;; Modeline
(setq-default mode-line-format
	  (list
	   mode-line-front-space
	   "%b"
	   mode-line-front-space
	   mode-line-modified
	   mode-line-front-space
	   "(%l,%c)"
	   mode-line-front-space
	   "%I"
	   mode-line-front-space
	   mode-line-modes))

;; Aliases
;; (defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'checkbox 'org-toggle-checkbox)
(defalias 'save 'save-buffer)
(defalias 'term 'st)
(defalias 'wdired 'wdired-change-to-wdired-mode)
