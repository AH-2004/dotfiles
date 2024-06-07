(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Icons
(use-package all-the-icons
  :config
  (setq all-the-icons-color-icons nil)
  (setq all-the-icons-scale-factor 1.0))

;; Sidebars
(use-package treemacs
  :disabled t
  :config
  (setq treemacs-width-is-locked nil)
  (setq treemacs-width-is-initially-locked nil)
  (setq treemacs-width 28)
  (setq treemacs-show-hidden-files t)
  (setq treemacs-is-never-other-window t)
  (load-file (concat custom-theme-directory "treemacs-all-the-icons.el"))
  (treemacs-load-theme "all-the-icons")
  (treemacs-follow-mode t)
  (treemacs-project-follow-mode t)
  (treemacs-filewatch-mode t))

(use-package neotree
  :config
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 28)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (setq neo-autorefresh t)
  (setq neo-show-hidden-files t)
  (setq neo-show-slash-for-folder nil)
  (setq neo-hide-cursor t)
  (setq neo-mode-line-type 'none))

;; Snippets
(use-package yasnippet
  :config
  (yas-global-mode))

;; Completions
(use-package corfu
  :config
  (setq corfu-auto t)
  (setq corfu-cycle t)
  (setq corfu-preview-current nil)
  (setq corfu-auto-prefix 2)
  (setq corfu-auto-delay 0.0)
  (setq corfu-min-width 50)
  (setq corfu-max-width corfu-min-width)
  (setq corfu-scroll-margin 4)
  (setq corfu-quit-no-match t)
  :init
  ;; (global-corfu-mode)
  (corfu-history-mode))

;; (use-package cape
;;   :config
;;   (setq-local completion-at-point-functions
;; 			  (list (cape-capf-super
;; 					 #'yasnippet-capf
;; 					 #'cape-file))))

(use-package kind-icon
  :after corfu
  :config
  (setq kind-icon-use-icons nil)
  (setq kind-icon-blend-background nil)
  (setq kind-icon-default-face 'corfu-default)
  (add-to-list 'corfu-margin-formatters
			   #'kind-icon-margin-formatter))

(use-package lsp-mode
  :disabled t
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-diagnostics-provider :none)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-lens-enable nil)
  (setq lsp-ui-doc-show-with-cursor nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-enable-snippet nil))

(use-package eglot
  :config
  (setq eglot-autoshutdown t)
  (setq eglot-report-progress nil)
  (add-to-list 'eglot-server-programs
			   '((c++-mode c-mode)
				 "clangd"
				 "--header-insertion=never"
				 "--all-scopes-completion=false"))
  (add-to-list 'eglot-stay-out-of 'flymake)
  (advice-add  'eglot-completion-at-point
			   :around #'cape-wrap-buster)
  (setq eglot-ignored-server-capabilities
		(list
		 :inlayHintProvider
		 :documentOnTypeFormattingProvider)))

;; (use-package lsp-bridge
;;   :ensure nil
;;   :disabled t
;;   :config
;;   (setq lsp-bridge-python-lsp-server "pylsp")
;;   (setq lsp-bridge-enable-diagnostics nil)
;;   (setq lsp-bridge-enable-inlay-hint nil)
;;   (setq acm-enable-search-file-words nil)
;;   (setq acm-backend-lsp-enable-auto-import nil)
;;   (setq acm-enable-doc nil))

(use-package eldoc
  :config
  (setq eldoc-echo-area-use-multiline-p nil))

;; Openwith
(use-package openwith
  :config
  (setq openwith-associations
		'(("\\.pdf\\'" "zathura" (file))
		  ("\\.epub\\'" "zathura" (file))
		  ("\\.docx\\'" "libreoffice" (file))
		  ("\\.pptx\\'" "libreoffice" (file))
		  ("\\.drawio\\'" "drawio" (file))
		  ("\\.mp4\\'" "mpv" (file))
		  ("\\.mkv\\'" "mpv" (file))
		  ("\\.svg\\'" "eog" (file))
		  ("\\.png\\'" "eog" (file))
		  ("\\.jpg\\'" "eog" (file))
		  ("\\.xopp\\'" "xournalpp" (file))))
  :init
  (openwith-mode t))

(use-package emms
  :config
  (setq emms-player-list '(emms-player-mpv))
  (setq emms-info-functions '(emms-info-native))
  (setq emms-playlist-buffer-name "*Emms*")
  (emms-mode-line -1)
  (emms-playing-time -1)
  :init
  (emms-all))

(use-package org-autolist
  :config
  (setq org-autolist-enable-delete nil))

(use-package org-download
  :config
  (setq org-download-annotate-function
		#'org-download-annotate-custom))

(use-package base16-theme
  :ensure nil
  :load-path "packages/base16-theme")

(use-package sql-indent
  :config
  (setq-default sqlind-basic-offset tab-width)
  (setq sqlind-indentation-offsets-alist
		`((select-clause 0)
		  (insert-clause 0)
		  (delete-clause 0)
		  (update-clause 0)
		  ,@sqlind-default-indentation-offsets-alist)))

;; Mu4e
(use-package mu4e
  :ensure nil
  :config
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-compose-format-flowed t)
  (setq mu4e-completing-read-function 'completing-read)
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/.mail/gmail")
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder "/Sent Mail")
  (setq mu4e-refile-folder "All Mail")
  (setq mu4e-trash-folder "/Trash"))

;; Nasm
(use-package nasm-mode
  :config
  (add-to-list 'auto-mode-alist
			   '("\\.asm\\'" . nasm-mode)))
;; Web
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist
			   '("\\.html?\\'" . web-mode)))

;; Multiple Cursors
(use-package multiple-cursors
  :config
  (setq mc/always-run-for-all t))

;; Others
(use-package texfrag)
(use-package cape)
(use-package tempel)
(use-package yasnippet-capf)
(use-package tree-sitter)
(use-package tree-sitter-langs)
(use-package eldoc-box)
(use-package format-all)
(use-package lua-mode)
(use-package buffer-move)
(use-package adaptive-wrap)
(use-package markdown-mode)
(use-package all-the-icons-dired)
(use-package drag-stuff)
(use-package lorem-ipsum)
(use-package org-download)
(use-package org-autolist)
(use-package rainbow-mode)
(use-package sudo-edit)
(use-package vertico :init (vertico-mode))
(use-package savehist :init (savehist-mode))
