;; Require packages
(require 'package)
(require 'org)
(require 'dired)
(require 'bookmark)
(require 'ibuffer)
(require 'wdired)
(require 'use-package)
(require 'use-package-ensure)
(require 'windmove)
(require 'align)
(require 'cc-mode)
(require 'asm-mode)

;; UI Tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(fringe-mode -1)
(pixel-scroll-precision-mode)
(setq-default use-dialog-box nil)
(setq-default use-file-dialog nil)
(setq-default frame-title-format '("Emacs " emacs-version))
(setq-default ring-bell-function 'ignore)
(setq-default scroll-conservatively 1)
(setq-default auto-window-vscroll nil)
(setq-default auto-hscroll-mode nil)
(setq-default org-image-actual-width (list 300))
(setq-default text-scale-mode-step 1.1)
(setq-default switch-to-buffer-obey-display-actions t)

;; Other Tweaks
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
(setq-default browse-url-generic-program 'browse-url-xdg-open)
(setq-default dired-kill-when-opening-new-dired-buffer t)
(setq-default dired-listing-switches "-lah --group-directories-first")
(setq-default completion-ignore-case t)
(setq-default read-file-name-completion-ignore-case t)
(setq-default read-buffer-completion-ignore-case t)
(setq-default initial-major-mode 'fundamental-mode)
(setq-default large-file-warning-threshold nil)
(setq-default ediff-ignore-similar-regions t)
(setq-default ediff-highlight-all-diffs nil)
(setq-default use-package-statistics t)
(defadvice split-window
	(after split-window-after activate)
  (other-window 1))
(add-to-list 'org-link-frame-setup
			 '(file . find-file))

(electric-pair-mode t)
(global-auto-revert-mode t)
(setq-default tab-width 4)
(setq-default c-basic-offset tab-width)
(setq-default c-ts-mode-indent-offset tab-width)
(setq-default typescript-ts-mode-indent-offset tab-width)
(setq-default python-indent-offset tab-width)
(setq-default vhdl-basic-offset tab-width)
(setq-default python-indent-offset tab-width)
(setq-default org-indent-indentation-per-level tab-width)
(setq-default org-edit-src-content-indentation tab-width)
(setq-default org-startup-shrink-all-tables t)
(setq-default org-support-shift-select 'always)
(setq-default org-replace-disputed-keys t)
(setq-default org-return-follows-link t)
(setq-default org-adapt-indentation t)
(setq-default org-indent-mode-turns-on-hiding-stars nil)
(setq-default backward-delete-char-untabify-method nil)
(setq-default cua-keep-region-after-copy nil)
(setq-default comment-style 'extra-line)
(setq-default tab-always-indent 'complete)
(put 'c-electric-paren 'delete-selection nil)
(put 'c-electric-brace 'delete-selection nil)

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
(load-theme 'base16-black t)
;; (load-theme 'base16-ocean t)

;; Mail
(setq-default user-mail-address "ahmedshuaib2004@gmail.com")
(setq-default user-full-name "Ahmed Shuaib")

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

;; Treesitter
(setq treesit-language-source-alist
	  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
		(c "https://github.com/tree-sitter/tree-sitter-c")
		(cmake "https://github.com/uyha/tree-sitter-cmake")
		(common-lisp "https://github.com/theHamsta/tree-sitter-commonlisp")
		(cpp "https://github.com/tree-sitter/tree-sitter-cpp")
		(css "https://github.com/tree-sitter/tree-sitter-css")
		(csharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
		(elisp "https://github.com/Wilfred/tree-sitter-elisp")
		(go "https://github.com/tree-sitter/tree-sitter-go")
		(go-mod "https://github.com/camdencheek/tree-sitter-go-mod")
		(html "https://github.com/tree-sitter/tree-sitter-html")
		(js . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
		(json "https://github.com/tree-sitter/tree-sitter-json")
		(lua "https://github.com/Azganoth/tree-sitter-lua")
		(make "https://github.com/alemuller/tree-sitter-make")
		(markdown "https://github.com/ikatyang/tree-sitter-markdown")
		(python "https://github.com/tree-sitter/tree-sitter-python")
		(r "https://github.com/r-lib/tree-sitter-r")
		(rust "https://github.com/tree-sitter/tree-sitter-rust")
		(toml "https://github.com/tree-sitter/tree-sitter-toml")
		(tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
		(typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
		(yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Aliases
(defalias 'y-or-n-p 'yes-or-no-p)
(defalias 'checkbox 'org-toggle-checkbox)
(defalias 'save 'save-buffer)
(defalias 'term 'st)
(defalias 'wdired 'wdired-change-to-wdired-mode)
(defalias 'mu 'mu4e)
