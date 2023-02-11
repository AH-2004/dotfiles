;; Auto save and backup
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Startup
(setq inhibit-startup-message t)

(defun init ()
  (message (emacs-init-time))
  (find-file "~/.emacs.d/*notes*")
  (cd "~")
  
  (when (get-buffer "*scratch*") (kill-buffer "*scratch*"))
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
)

;; (defun display-startup-echo-area-message () (message (emacs-init-time)))

;; Hooks
(add-hook 'server-after-make-frame-hook 'init)
(add-hook 'after-init-hook 'init)

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(setq user-dialog-box nil)
(setq frame-title-format '("Emacs " emacs-version))
(setq ring-bell-function 'ignore)
(setq python-indent-guess-indent-offset-verbose nil)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; Editing Tweaks
(setq-default tab-width 4)
(electric-pair-mode t)

;; Functions

;; Comment
(defun comment ()
  (interactive)
  (point-to-register 1)
  (comment-line 1)
  (previous-line 1)
  (jump-to-register 1)
)

;; Move current line
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
)

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (jump-to-register 1)
)

;; Copy whole line
(defun copy-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line 1)
  (yank)
  (open-line 1)
)

;; Paste whole line
(defun paste-line ()
  (interactive)
  (open-line 1)
  (next-line)
  (yank)
)

;; Delete whole line
(defun delete-line ()
  (interactive)
  (beginning-of-line 1)
  (delete-region
   (point)
   (save-excursion
	 (move-end-of-line 1)
	 (point)
   )
  )
  ;; (delete-backward-char 1)
  ;; ^ Enable if you want to remove \n char
)

;; Undo
(defun redo ()
  (interactive)
  (undo-redo 1)
  (end-of-line 1)
)


;; CUA
(cua-mode t)
(setq cua-keep-region-after-copy nil)

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'default-frame-alist '(font . "Consolas 10"))
;; (load-theme 'tron-legacy t)
(load-theme 'dracula t)
;; (load-theme 'exotica t)

;; Packages
(require 'package)
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
  (treemacs-project-follow-mode t)
  (treemacs-filewatch-mode t)  
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

;; Completions
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.25)
  (corfu-quit-no-match nil)

  :init
  (global-corfu-mode)
)

(use-package lsp-mode
  :config
  (setq lsp-auto-guess-root t)
)

(use-package lsp-ui
  :init
  (lsp-ui-mode)
)

(use-package vertico
  :init
  (vertico-mode)
)

(use-package savehist
  :init
  (savehist-mode)
)

;; Path
(add-to-list 'exec-path "~/.local/bin")

;; Keybindings

;; Sidebar toggling
(bind-key* "C-S-K" 'neotree-toggle)
;; (bind-key* "C-S-K" 'treemacs)

;; Zoom
(bind-key* "C-=" 'text-scale-increase)
(bind-key* "C--" 'text-scale-decrease)

;; Toggle line numbers
(bind-key* "C-S-g" 'display-line-numbers-mode)

;; Move lines
(bind-key* "C-S-<up>" 'move-line-up)
(bind-key* "C-S-<down>" 'move-line-down)

;; Completions
(bind-key* "C-SPC" 'completion-at-point)

;; Comments
(bind-key* "C-/" 'comment)

;; Copy/Paste line
(bind-key* "C-c C-c" 'copy-line)
(bind-key* "C-c C-v" 'paste-line)

;; Delete line
(bind-key* "S-<delete>" 'delete-line)

;; Redo
(bind-key* "C-y" 'redo)

;; Make new frame
(bind-key* "C-n" 'make-frame)

;; Set seperate file for customize commands
(setq custom-file (concat user-emacs-directory "/custom.el"))
