(defun init ()
  (message (emacs-init-time))
  (find-file "~/.emacs.d/*notes*")
  (cd "~")
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
)

;; Comment line or region
(defun comment ()
  (interactive)
  (point-to-register 1)
  (comment-line 1)
  (previous-line 1)
  (jump-to-register 1))

(defun align-comments (begin end)
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\)//" 1 1 t))

;; Delete whole line
(defun delete-line ()
  (interactive)
  (delete-region
   (line-beginning-position)
   (line-end-position))
  (delete-backward-char 1))

;; Delete word
(defun delete-word (arg)
  (interactive "p")
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-region (point) (progn (forward-word arg) (point)))))

(defun backward-delete-word (arg)
  (interactive "p")
  (delete-word (- arg)))

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

;; Redo
(defun redo ()
  (interactive)
  (undo-redo 1)
  (end-of-line 1))

(defun other-window-back ()
  (interactive)
  (other-window -1))

;; Toggle Line number type
(defun display-line-numbers-relative ()
  (interactive)
   (if (eq display-line-numbers 'relative)
      (setq display-line-numbers t)
    (setq display-line-numbers 'relative)))

;; Insert current date
(defun today ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +'%B %d, %Y')")))

(setq mode-line-time
	  '(:eval
		(string-trim-right
		 (shell-command-to-string
		  "date +'%r'"))))

;; Terminal
(defun st ()
  (interactive)
  (call-process-shell-command "st" nil 0))

;; playerctl
(setq mode-line-playerctl
	  '(:eval
		(string-trim-right
		 (shell-command-to-string
		  "playerctl -s -i chromium metadata --format ' [{{artist}} - {{title}}]'"))))

(defun playerctl-play-pause ()
  (interactive)
  (call-process-shell-command "playerctl -s -i chromium play-pause"))

(defun playerctl-next ()
  (interactive)
  (call-process-shell-command "playerctl -s -i chromium next"))

(defun playerctl-previous ()
  (interactive)
  (call-process-shell-command "playerctl -s -i chromium previous"))

;; Insert src block
(defun org-src-block ()
  (interactive)
  (org-insert-structure-template "src"))

;; Update org file
(defun org-update ()
  (interactive)
  (universal-argument)
  (org-update-statistics-cookies t))

;; Org Download markup
(defun org-download-annotate-custom (link)
  "#+ATTR_HTML: :width 300px\n")

(defun tst ()
  (interactive)
  (message "%s" "Test"))
