;; This file contains all the important parts form my config
;; the goal being a portable setup.

;; Packages
(add-to-list 'load-path "~/.emacs.d/packages")
(require 'dired)
(require 'bookmark)
(require 'ibuffer)
(require 'isearch)
(require 'bind-key)
(require 'org)
(require 'eglot)
(require 'drag-stuff)
(require 'vertico)
(require 'corfu)

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(fringe-mode -1)
(pixel-scroll-precision-mode)
(vertico-mode)
(savehist-mode)
(setq-default use-dialog-box nil)
(setq-default use-file-dialog nil)
(setq-default frame-title-format '("Emacs " emacs-version))
(setq-default ring-bell-function 'ignore)
(setq-default scroll-conservatively 1)
(setq-default auto-window-vscroll nil)
(setq-default auto-hscroll-mode nil)
(setq-default text-scale-mode-step 1.1)

;; Other Tweaks
(setq-default auto-save-default nil)
(setq-default make-backup-files nil)
(setq-default create-lockfiles nil)
(setq-default inhibit-startup-message t)
(setq-default inhibit-startup-echo-area-message t)
(setq-default initial-scratch-message nil)
(setq-default frame-resize-pixelwise t)
;; (setq-default gc-cons-threshold 100000000)
;; (setq-default read-process-output-max (* 1024 1024))
(setq-default dired-kill-when-opening-new-dired-buffer t)
(setq-default dired-listing-switches "-lah --group-directories-first")
(setq-default completion-ignore-case t)
(setq-default read-file-name-completion-ignore-case t)
(setq-default read-buffer-completion-ignore-case t)
(setq-default initial-major-mode 'fundamental-mode)
(defadvice split-window
	(after split-window-after activate)
  (other-window 1))

;; Editing Tweaks
(electric-pair-mode t)
(global-auto-revert-mode t)
(setq-default tab-width 4)
(setq-default c-basic-offset tab-width)
(setq-default backward-delete-char-untabify-method nil)
(setq-default cua-keep-region-after-copy nil)
(setq-default tab-always-indent 'complete)

;; Org Mode
(setq-default org-indent-indentation-per-level tab-width)
(setq-default org-edit-src-content-indentation tab-width)
(setq-default org-startup-shrink-all-tables t)
(setq-default org-support-shift-select 'always)
(setq-default org-replace-disputed-keys t)
(setq-default org-return-follows-link t)
(setq-default org-adapt-indentation t)
(setq-default org-indent-mode-turns-on-hiding-stars nil)

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

;; Completions
(setq eglot-autoshutdown t)
(setq eglot-report-progress nil)
(add-to-list 'eglot-server-programs
			 '((c++-mode c-mode)
			   "clangd"
			   "--header-insertion=never"
			   "--all-scopes-completion=false"))
(add-to-list 'eglot-stay-out-of 'flymake)
(setq eglot-ignored-server-capabilities
	  (list
	   :inlayHintProvider
	   :documentOnTypeFormattingProvider))

(setq corfu-auto t)
(setq corfu-cycle t)
(setq corfu-preview-current nil)
(setq corfu-auto-prefix 2)
(setq corfu-auto-delay 0.0)
(setq corfu-min-width 50)
(setq corfu-max-width corfu-min-width)
(setq corfu-scroll-margin 4)
(setq corfu-quit-no-match t)

;; Functions
(defun comment ()
  (interactive)
  (point-to-register 1)
  (comment-line 1)
  (previous-line 1)
  (jump-to-register 1))

(defun delete-line ()
  (interactive)
  (delete-region
   (line-beginning-position)
   (line-end-position))
  (delete-backward-char 1))

(defun delete-word (arg)
  (interactive "p")
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-region (point) (progn (forward-word arg) (point)))))

(defun backward-delete-word (arg)
  (interactive "p")
  (delete-word (- arg)))

(defun duplicate-line ()
  (interactive)
  (kill-new (concat
			 "\n"
			 (buffer-substring
			  (line-beginning-position)
			  (line-end-position))))
  (move-end-of-line 1)
  (yank))

(defun copy-line ()
  (interactive)
  (kill-new (buffer-substring
			 (line-beginning-position)
			 (line-end-position))))

(defun redo ()
  (interactive)
  (undo-redo 1)
  (end-of-line 1))

(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

(defun org-src-block ()
  (interactive)
  (org-insert-structure-template "src"))

(defun display-line-numbers-toggle ()
  (interactive)
  (cond ((eq display-line-numbers nil)
		 (setq display-line-numbers t))
		((eq display-line-numbers t)
		 (setq display-line-numbers 'relative))
		((eq display-line-numbers 'relative)
		 (setq display-line-numbers nil))))

;; Keybindings
(bind-key* "C-=" 'text-scale-increase)
(bind-key* "C--" 'text-scale-decrease)
(bind-key* "C-0" 'text-scale-reset)
(bind-key* "C-S-g" 'display-line-numbers-toggle)
(bind-key* "C-S-<up>" 'drag-stuff-up)
(bind-key* "C-S-<down>" 'drag-stuff-down)
(bind-key* "C-SPC" 'completion-at-point)
(bind-key* "C-/" 'comment)
(bind-key* "C-a" 'mark-whole-buffer)
(bind-key* "C-x SPC" 'set-mark-command)
(bind-key* "C-c C-v" 'duplicate-line)
(bind-key* "S-<delete>" 'delete-line)
(bind-key* "C-<backspace>" 'backward-delete-word)
(bind-key* "C-<delete>" 'delete-word)
(bind-key* "C-z" 'undo)
(bind-key* "C-y" 'redo)
(bind-key* "C-f" 'isearch-forward)
(bind-key* "C-S-f" 'replace-string)
(bind-key* "C-S-s" 'ispell-region)
(bind-key* "C-n" 'dired-create-empty-file)
(bind-key* "C-S-n" 'dired-create-directory)
(bind-key* "C-x k" 'kill-buffer)
(bind-key* "C-x r" 'rename-buffer)
(bind-key* "C-x C-d" 'dired-jump)
(bind-key* "C-x C-b" 'ibuffer)
(bind-key* "M-<home>" 'beginning-of-buffer)
(bind-key* "M-<end>" 'end-of-buffer)
(bind-key* "<escape>" 'keyboard-escape-quit)
(bind-key* "C-<prior>" 'enlarge-window-horizontally)
(bind-key* "C-S-<prior>" 'enlarge-window)
(bind-key* "C-<next>" 'shrink-window-horizontally)
(bind-key* "C-S-<next>" 'shrink-window)

(bind-key  "C-f" 'isearch-repeat-forward isearch-mode-map)
(bind-key "<backspace>" 'isearch-del-char isearch-mode-map)
(bind-key  "<backtab>" 'org-src-block org-mode-map)
(bind-key "<deletechar>" 'dired-do-delete dired-mode-map)
(bind-key "<f2>" 'dired-do-rename dired-mode-map)

(unbind-key "<insert>")
(unbind-key "<insertchar>")
(unbind-key "S-<down-mouse-1>")
(unbind-key "C-<down-mouse-1>")
(unbind-key "C-<down-mouse-3>")
(unbind-key "<mouse-2>")
(unbind-key "C-x C-z")
(cua-mode t)

;; (load-theme 'modus-vivendi-tinted)

(add-hook 'prog-mode-hook
		  (lambda ()
			;; (corfu-mode)
			(display-line-numbers-mode 1)))

(add-hook 'text-mode-hook
		  (lambda ()
			(setq display-line-numbers nil)
			(set-fringe-mode 0)
			(turn-on-visual-line-mode)))

(add-hook 'dired-mode-hook
		  (lambda ()
			(auto-revert-mode)
			(dired-hide-details-mode)
			(turn-on-visual-line-mode)))

(add-hook 'c++-mode-hook 'eglot-ensure)
