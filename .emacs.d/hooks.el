(add-hook 'server-after-make-frame-hook 'init)
(add-hook 'after-init-hook 'init)

(add-hook 'prog-mode-hook
		  (lambda ()
			;; (tree-sitter-hl-mode)
			(display-line-numbers-mode 1)))

(add-hook 'text-mode-hook
		  (lambda ()
			(setq left-margin-width 5)
			(setq right-margin-width 5)
			(setq display-line-numbers nil)
			(set-fringe-mode 0)
			(turn-on-visual-line-mode)
			(adaptive-wrap-prefix-mode)))

(add-hook 'dired-mode-hook
		  (lambda ()
			(auto-revert-mode)
			(all-the-icons-dired-mode)
			(dired-hide-details-mode)))

(add-hook 'org-mode-hook
		  (lambda ()
			(org-autolist-mode)))

(add-hook 'c++-mode-hook
		  (lambda ()
			(eglot-ensure)
			(tree-sitter-hl-mode)))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'js-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

(add-hook 'asm-mode-hook
		  (lambda ()
			(local-unset-key (char-to-string asm-comment-char))
			(local-unset-key ":")
			(setq tab-always-indent (default-value 'tab-always-indent))))
