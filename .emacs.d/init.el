;; Auto save and backup
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Startup
(setq inhibit-startup-message t)
(setq frame-resize-pixelwise t)

(defun init ()
  (message (emacs-init-time))
  (find-file "~/.emacs.d/*notes*")
  (cd "~")  
  (when (get-buffer "*scratch*") (kill-buffer "*scratch*"))
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
)

;; Require packages
(require 'package)
(require 'org)

;; Hooks
(add-hook 'server-after-make-frame-hook 'init)
(add-hook 'after-init-hook 'init)
(add-hook 'dired-mode-hook 'auto-revert-mode)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'dired-mode-hook (lambda () (local-set-key (kbd "RET") #'dired-find-alternate-file)))

;; Writeroom hooks
(add-hook 'writeroom-mode-enable-hook (lambda () (setq display-line-numbers nil) (set-fringe-mode 0) (centaur-tabs-mode -1)))
(add-hook 'writeroom-mode-disable-hook (lambda () (setq display-line-numbers t) (set-fringe-mode nil) (centaur-tabs-mode 1)))

;; Tab hooks
;; (add-hook 'vterm-mode-hook 'centaur-tabs-local-mode)

;; LSP hooks
(add-hook 'python-mode-hook 'lsp-deferred)
(add-hook 'js-mode-hook 'lsp-deferred)
(add-hook 'c++-mode-hook 'lsp-deferred)
(add-hook 'c-mode-hook 'lsp-deferred)

;; Org mode hooks
(add-hook 'org-mode-hook 'org-modern-mode)
(add-hook 'org-mode-hook 'org-autolist-mode)

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook (lambda () (setq left-margin-width 5) (setq right-margin-width 5)))
(setq user-dialog-box nil)
(setq frame-title-format '("Emacs " emacs-version))
(setq ring-bell-function 'ignore)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(setq org-image-actual-width nil)
(add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))
(defadvice split-window (after split-window-after activate) (other-window 1))

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
	   mode-line-modes
	   ))

;; Other tweaks
(setq python-indent-guess-indent-offset-verbose nil)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq browse-url-browser-function 'browse-url-xdg-open)
(put 'dired-find-alternate-file 'disabled nil)
(global-auto-revert-mode t)

;; Editing Tweaks
(setq-default tab-width 4)
(setq-default c-basic-offset tab-width)
(setq-default python-indent-offset tab-width)
(electric-pair-mode t)
(setq org-support-shift-select t)

;; Functions

;; Comment
(defun comment ()
  (interactive)
  (point-to-register 1)
  (comment-line 1)
  (previous-line 1)
  (jump-to-register 1)
)

;; Delete whole line
(defun delete-line ()
  (interactive)
  (delete-region (line-beginning-position) (line-end-position))
  (delete-backward-char 1)
)

;; Copy and Duplicate line
(defun duplicate-line ()
  (interactive)
  (kill-new (concat "\n" (buffer-substring (line-beginning-position) (line-end-position))))
  (move-end-of-line 1)
  (yank)
)

;; insert current date
(defun today ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +'%B %d, %Y')"))
)

;; Redo
(defun redo ()
  (interactive)
  (undo-redo 1)
  (end-of-line 1)
)

;; Handle sidebar
(defun toggle-sidebar ()
  (interactive)
  (neotree-toggle)
  ;; (treemacs)
  ;; (dired-sidebar-toggle-sidebar)
)

(defun org-update ()
  (interactive)
  (universal-argument)
  (org-update-statistics-cookies t)
)

(defun tst ()
  (interactive)
  (message "Hello World")
)

;; Set seperate file for customize commands
(setq custom-file "~/.emacs.d/custom.el")

;; Path
(add-to-list 'exec-path "~/.local/bin")

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'default-frame-alist '(font . "Consolas 10"))
;; (add-to-list 'default-frame-alist '(font . "Liberation 10"))
;; (load-theme 'tron-legacy t)
;; (load-theme 'dracula t)
;; (load-theme 'exotica t)
;; (load-theme 'white-sand t)
(load-theme 'wilmersdorf t)

;; Packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Icons
(use-package all-the-icons
  :config
  (setq all-the-icons-color-icons nil)
  (setq all-the-icons-scale-factor 1.0)  
)

;; Sidebars

;; Treemacs
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

(use-package dired-sidebar
  :init
    (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  
  :config
  (setq dired-sidebar-theme 'nerd)
)

;; Completions
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  ;; (corfu-auto-delay 0.25)
  (corfu-auto-delay 0.05)
  ;; (corfu-quit-no-match nil)
  (corfu-min-width 40)
  (corfu-max-width corfu-min-width)
  (corfu-scroll-magin 4)
  
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

;; Tabs
(use-package centaur-tabs
  :disabled t
  :init
  (centaur-tabs-mode t)
  :config
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-show-new-tab-button nil)
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-height 24)
  (setq centaur-tabs-show-navigation-buttons t)
  (setq centaur-tabs-set-modified-marker t)
  (centaur-tabs-change-fonts "Consolas" 100)
)
(defun centaur-tabs-buffer-groups ()
  (list
   (cond
	((or
	  (string-equal (buffer-name) "*notes*")
	  (string-equal (buffer-name) "*Messages*")
	  (and (buffer-file-name)
		   (string-equal
			(file-name-directory (buffer-file-name))
			(string-replace "~" (getenv "HOME") user-emacs-directory)
			)
		   )
	  )"emacs")

	((or
	  (string-equal (buffer-name) "*pylsp*")
	  (string-equal (buffer-name) "*pylsp::stderr*")
	  (string-equal (buffer-name) "*texlab*")
	  (string-equal (buffer-name) "*texlab::stderr*")
	  (string-equal (buffer-name) "*clangd*")
	  (string-equal (buffer-name) "*clangd::stderr*")
	  )"lsp")
	
	((or
	  (string-equal (major-mode) "vterm-mode")
	  )"Vterm")

	(t "others") ;; This is where the buffers will go if none of the about conditions are met.
	
	(t (centaur-tabs-get-group-name (current-buffer)))
   )
  )
)

;; Writeroom
(use-package writeroom-mode
  :config
  (setq writeroom-width 0.9)
  (setq writeroom-fringes-outside-margins nil)
)

;; Openwith
(use-package openwith
  :init
  (openwith-mode t)
  :config
  (setq openwith-associations '(("\\.pdf\\'" "zathura" (file))))
)

;; (use-package org-padding
;;  :config
;;  (setq org-padding-block-begin-line-padding '(1 . 1))
;;  (setq org-padding-block-end-line-padding '(1 . 1))
;;  )

(use-package multi-vterm)
(use-package vertico :init (vertico-mode))
(use-package savehist :init (savehist-mode))
(use-package good-scroll :init (good-scroll-mode))
(use-package org-autolist)
(use-package org-modern)

;; Aliases
(defalias 'zen 'writeroom-mode)
(defalias 'checkbox 'org-toggle-checkbox)
(defalias 'save 'save-buffer)
(defalias 'term 'multi-vterm)

;; Keybindings

;; Sidebar toggling
(bind-key* "C-S-K" 'toggle-sidebar)

;; Zoom
(bind-key* "C-=" 'text-scale-increase)
(bind-key* "C--" 'text-scale-decrease)

;; Toggle line numbers
(bind-key* "C-S-g" 'display-line-numbers-mode)

;; Move lines
(bind-key* "C-S-<up>" 'drag-stuff-up)
(bind-key* "C-S-<down>" 'drag-stuff-down)

;; Completions
(bind-key* "C-SPC" 'completion-at-point)

;; Comments
(bind-key* "C-/" 'comment)

;; Mark all
(bind-key* "C-a" 'mark-whole-buffer)

;; Copy/Paste/Cut
(bind-key* "C-c C-v" 'duplicate-line)

;; Delete line
(bind-key* "S-<delete>" 'delete-line)

;; Undo/Redo
(bind-key* "C-z" 'undo)
(bind-key* "C-y" 'redo)

;; Search stuff
(bind-key* "C-f" 'isearch-forward)
(bind-key "C-f" 'isearch-repeat-forward isearch-mode-map)
(bind-key "<tab>" 'isearch-repeat-forward isearch-mode-map)
(bind-key "<backspace>" 'isearch-del-char isearch-mode-map)

;; Dired
(bind-key* "C-n" 'dired-create-empty-file)
(bind-key "<deletechar>" 'dired-do-delete dired-mode-map)
(bind-key "<f2>" 'dired-do-rename dired-mode-map)
;; Org mode
(bind-key "C-e" 'org-modern-mode org-mode-map)

;; Terminal
(bind-key* "C-x t" 'term)
(bind-key "C-S-v" 'vterm-yank)

;; Tabs
(bind-key* "C-<tab>" 'centaur-tabs-forward)
(bind-key* "C-<iso-lefttab>" 'centaur-tabs-backward)
(bind-key* "C-x <right>" 'centaur-tabs-forward-group)
(bind-key* "C-x <left>" 'centaur-tabs-backward-group)

;; Buffers and windows
(bind-key* "C-x k" 'kill-buffer-and-window)

;; Unbind unwanted keys
(unbind-key "<insert>")
(unbind-key "<insertchar>")
(unbind-key "C-x C-z")
;; (bind-key* "C-x C-z" 'tst)

;; CUA
(cua-mode t)
(setq cua-keep-region-after-copy nil)
