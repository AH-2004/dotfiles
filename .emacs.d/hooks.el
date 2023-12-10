(add-hook 'server-after-make-frame-hook 'init)
(add-hook 'after-init-hook 'init)

(add-hook 'prog-mode-hook
		  (lambda ()
			(display-line-numbers-mode 1)))

(add-hook 'text-mode-hook
		  (lambda ()
			(setq left-margin-width 5)
			(setq right-margin-width 5)
			(setq display-line-numbers nil)
			(set-fringe-mode 0)
			(turn-on-visual-line-mode)
			(adaptive-wrap-prefix-mode)
			))

(add-hook 'dired-mode-hook
		  (lambda ()
			(auto-revert-mode)
			(all-the-icons-dired-mode)))

(add-hook 'org-mode-hook
		  (lambda ()
			;; (org-modern-mode)
			(org-autolist-mode)))

(add-hook 'eglot-managed-mode-hook
		  (lambda ()
			(eglot-inlay-hints-mode -1)))

(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'js-mode-hook 'eglot-ensure)
