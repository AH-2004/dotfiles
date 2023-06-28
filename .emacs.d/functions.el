;; Comment line or region
(defun comment ()
  (interactive)
  (point-to-register 1)
  (comment-line 1)
  (previous-line 1)
  (jump-to-register 1))

;; Delete whole line
(defun delete-line ()
  (interactive)
  (delete-region
   (line-beginning-position)
   (line-end-position))
  (delete-backward-char 1))

;; Duplicate line
(defun duplicate-line ()
  (interactive)
  (kill-new (concat
			 "\n"
			 (buffer-substring
			  (line-beginning-position)
			  (line-end-position))))
  (move-end-of-line 1)
  (yank))

;; Copy line
(defun copy-line ()
  (interactive)
  (kill-new (buffer-substring
			 (line-beginning-position)
			 (line-end-position))))

;; Insert current date
(defun today ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +'%B %d, %Y')")))

;; Redo
(defun redo ()
  (interactive)
  (undo-redo 1)
  (end-of-line 1))

;; Update org file
(defun org-update ()
  (interactive)
  (universal-argument)
  (org-update-statistics-cookies t))

(defun tst ()
  (interactive)
  (message "%s" (file-name-nondirectory
				 (directory-file-name
				  (file-name-directory buffer-file-name))))
  ;; (message "%s" (file-name-nondirectory (directory-file-name default-directory)))
  )
