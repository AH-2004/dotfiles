(add-hook 'server-after-make-frame-hook 'init)
(add-hook 'after-init-hook 'init)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
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
			(all-the-icons-dired-mode)))

(add-hook 'org-mode-hook
		  (lambda ()
			(org-modern-mode)
			(org-autolist-mode)))

(add-hook 'eglot-managed-mode-hook
		  (lambda ()
			(flymake-mode -1)
			(eglot-inlay-hints-mode -1)))

;; (add-hook 'c++-mode-hook 'eglot-ensure)
;; (add-hook 'c-mode-hook 'eglot-ensure)