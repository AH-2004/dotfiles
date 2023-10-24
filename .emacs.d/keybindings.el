;; Sidebar
(bind-key* "C-S-k" 'neotree-toggle)
(bind-key "S-<return>" 'neotree-change-root neotree-mode-map)
(bind-key "<deletechar>" 'neotree-delete-node neotree-mode-map)
(bind-key "<f2>" 'neotree-rename-node neotree-mode-map)

;; Zoom
(bind-key* "C-=" 'text-scale-increase)
(bind-key* "C--" 'text-scale-decrease)

;; Toggle line numbers
(bind-key* "C-S-g" 'display-line-numbers-mode)

;; Move lines
(bind-key* "C-S-<up>" 'drag-stuff-up)
(bind-key* "C-S-<down>" 'drag-stuff-down)

;; Completions
(bind-key* "C-SPC" 'completion-at-point)
(bind-key* "M-h" 'eldoc-box-help-at-point)

;; Comments
(bind-key* "C-/" 'comment)

;; Mark all
(bind-key* "C-a" 'mark-whole-buffer)

;; Copy/Paste/Cut
(bind-key* "C-c C-v" 'duplicate-line)

;; Delete line
(bind-key* "S-<delete>" 'delete-line)

;; Delete word
(bind-key* "M-DEL" 'backward-delete-word)
(bind-key* "C-<backspace>" 'backward-delete-word)
(bind-key* "M-d" 'delete-word)
(bind-key* "C-<delete>" 'delete-word)

;; Undo/Redo
(bind-key* "C-z" 'undo)
(bind-key* "C-y" 'redo)

;; Search stuff
(bind-key* "C-f" 'isearch-forward)
(bind-key* "C-S-f" 'replace-string)
(bind-key "C-f" 'isearch-repeat-forward isearch-mode-map)
(bind-key "<tab>" 'isearch-repeat-forward isearch-mode-map)
(bind-key "<backspace>" 'isearch-del-char isearch-mode-map)

;; Ispell
(bind-key* "C-S-s" 'ispell-region)

;; Dired
(bind-key* "C-n" 'dired-create-empty-file)
(bind-key* "C-d" 'dired-create-directory)
(bind-key "<deletechar>" 'dired-do-delete dired-mode-map)
(bind-key "<f2>" 'dired-do-rename dired-mode-map)

;; Org mode
(bind-key "C-e" 'org-modern-mode org-mode-map)
(bind-key "<backtab>" 'org-src-block org-mode-map)

;; Terminal
(bind-key* "C-x t" 'term)

;; Buffers and windows
;; (bind-key* "C-x k" 'kill-buffer-and-window)
(bind-key* "C-x k" 'kill-buffer)
(bind-key* "C-x r" 'rename-buffer)
(bind-key* "C-x C-b" 'switch-to-buffer)
(bind-key* "C-x <up>" 'buf-move-up)
(bind-key* "C-x <down>" 'buf-move-down)
(bind-key* "C-x <left>" 'buf-move-left)
(bind-key* "C-x <right>" 'buf-move-right)
(bind-key* "C-<tab>" 'other-window)
(bind-key* "C-<iso-lefttab>" 'other-window-back)
(bind-key* "C-x 4" 'clone-indirect-buffer-other-window)
(bind-key* "M-<prior>" 'beginning-of-buffer)
(bind-key* "M-<next>" 'end-of-buffer)

;; Unbind global unwanted keys
(unbind-key "<insert>")
(unbind-key "<insertchar>")
(unbind-key "S-<down-mouse-1>")
(unbind-key "C-<down-mouse-1>")
(unbind-key "C-<down-mouse-3>")
(unbind-key "C-x C-z")
;; (bind-key* "C-x C-z" 'tst)

;; CUA
(cua-mode t)
