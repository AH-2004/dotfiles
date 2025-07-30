(defun init ()
  (message (emacs-init-time))

  (setq-local connectable
			  (string=
			   (string-trim
				(shell-command-to-string
				 "ssh-keyscan AH-THINK >/dev/null 2>&1; echo $?")) "0"))

  (if (and connectable (file-exists-p "/ssh:AH-THINK:.emacs.d/*notes*"))
	  (progn
		(find-file "/ssh:AH-THINK:.emacs.d/*notes*")
		;; (copy-file "~/.emacs.d/*notes*" "~/.emacs.d/*notes*.backup" nil)
		;; (copy-file "/ssh:AH-THINK:.emacs.d/*notes*" "~/.emacs.d/*notes*" t)
		)
	(progn
	  (message "%s" "Unable to connect/access *notes* from AH-THINK")
	  (find-file "~/.emacs.d/*notes*")))
  
  (if (get-buffer "*Compile-Log*")
	  (kill-buffer "*Compile-Log*"))
  
  (setq default-directory "~/")
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

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

;; Reset text scale
(defun text-scale-reset ()
  (interactive)
  (text-scale-set 0))

;; Toggle Line number type
(defun display-line-numbers-toggle ()
  (interactive)
  (cond ((eq display-line-numbers nil)
		 (setq display-line-numbers t))
		((eq display-line-numbers t)
		 (setq display-line-numbers 'relative))
		((eq display-line-numbers 'relative)
		 (setq display-line-numbers nil))))

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
  (org-update-statistics-cookies t)
  (org-redisplay-inline-images))

;; Org Checkbox WIP
(defun org-checkbox-wip-p ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (re-search-forward "- \\[\\(-\\)\\]" (point-at-eol) t)))

(defun org-toggle-checkbox-wip ()
  (interactive)
  (if (org-checkbox-wip-p)
	  (save-excursion (replace-match "- [ ]"))
	  (org-toggle-checkbox '(16))))

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

;; Bookmarks
(defun bookmarks ()
  (interactive)
  (find-file-read-only (concat user-emacs-directory "*bookmarks*"))
  (advice-add 'org-open-at-point :after
			  (lambda (&rest r)
				(kill-buffer "*bookmarks*"))))

(defun tst ()
  (interactive)
  (message "%s" "Test"))
