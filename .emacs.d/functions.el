(defun init ()
  (message (emacs-init-time))
  (find-file "~/.emacs.d/*notes*")
  (setq default-directory "~/")
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Predicates
(defun current-line-empty-p ()
  (string-match-p
   "\\`\\s-*$"
   (buffer-substring
	(line-beginning-position)
	(line-end-position))))

;; Comment line or region
(defun comment ()
  (interactive)
  (point-to-register 1)
  (comment-line 1)
  (previous-line 1)
  (jump-to-register 1))

(defun comment-other ()
  (interactive)
  (if (current-line-empty-p)
	  (progn
		(c-indent-line)
		(insert "/*\n\n*/")
		(c-indent-line)
		(previous-line)
		(c-indent-line)
		(end-of-line))
	(progn (end-of-line) (insert " // "))))

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

;; Reset text scale
(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

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
(defun st-remote ()
  (setq dir
		(split-string
		 (substring
		  default-directory 5)
		 ":"))
  (setq commandStr
		(concat
		 "st ssh "
		 (nth 0 dir)
		 " -t 'cd "
		 (nth 1 dir)
		 "; exec $SHELL'"))
  (call-process-shell-command commandStr nil 0))

(defun st ()
  (interactive)
  (if (file-remote-p default-directory)
	  (st-remote)
	(call-process-shell-command "st" nil 0)))

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

;; File Manager
(defun pcmanfm ()
  (interactive)
  (call-process-shell-command "pcmanfm ." nil 0))

;; Insert src block
(defun org-src-block ()
  (interactive)
  (org-insert-structure-template "src"))

;; Update org file
(defun org-update ()
  (interactive)
  (universal-argument)
  (org-update-statistics-cookies t))

(defun org-toggle-intermediate ()
  (interactive)
  (org-toggle-checkbox))

;; Org Download markup
(defun org-download-annotate-custom (link)
  "#+ATTR_HTML: :width 300px\n")

;; increase/decrease alpha
(defun alpha-increase ()
  (interactive)
  (if (eq (frame-parameter nil 'alpha-background) nil)
	  (set-frame-parameter nil 'alpha-background 100))
  (if (< (frame-parameter nil 'alpha-background) 100)
	(set-frame-parameter nil 'alpha-background
						 (+ (frame-parameter nil 'alpha-background) 5))))

(defun alpha-decrease ()
  (interactive)
  (if (eq (frame-parameter nil 'alpha-background) nil)
	  (set-frame-parameter nil 'alpha-background 100))
  (if (> (frame-parameter nil 'alpha-background) 0)
	(set-frame-parameter nil 'alpha-background
						 (- (frame-parameter nil 'alpha-background) 5))))

(defun alpha-reset ()
  (interactive)
  (set-frame-parameter nil 'alpha-background 100))

(defun tst ()
  (interactive)
  (message "%s" "Test")
  (c-indent-line))
