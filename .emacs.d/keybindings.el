;; Sidebar
(bind-key* "C-S-k" 'neotree-toggle)
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

;; Comments
(bind-key* "C-/" 'comment)

;; Mark all
(bind-key* "C-a" 'mark-whole-buffer)

;; Copy/Paste/Cut
(bind-key* "C-c C-v" 'duplicate-line)

;; Delete line
(bind-key* "S-<delete>" 'delete-line)

;; Undo/Redo
(bind-key* "C-z" 'undo)
(bind-key* "C-y" 'redo)

;; Search stuff
(bind-key* "C-f" 'isearch-forward)
(bind-key* "C-S-f" 'replace-string)
(bind-key "C-f" 'isearch-repeat-forward isearch-mode-map)
(bind-key "<tab>" 'isearch-repeat-forward isearch-mode-map)
(bind-key "<backspace>" 'isearch-del-char isearch-mode-map)

;; Dired
(bind-key* "C-n" 'dired-create-empty-file)
(bind-key* "C-d" 'dired-create-directory)
(bind-key "<deletechar>" 'dired-do-delete dired-mode-map)
(bind-key "<f2>" 'dired-do-rename dired-mode-map)

;; Org mode
(bind-key "C-e" 'org-modern-mode org-mode-map)

;; Terminal
(bind-key* "C-x t" 'term)
(bind-key "C-S-v" 'vterm-yank)
(bind-key "C-l" 'vterm-clear)
(bind-key "C-S-l" 'vterm-clear-scrollback)

;; Buffers and windows
;; (bind-key* "C-x k" 'kill-buffer-and-window)
(bind-key* "C-x k" 'kill-buffer)
(bind-key* "C-x r" 'rename-buffer)
(bind-key* "C-x <up>" 'buf-move-up)
(bind-key* "C-x <down>" 'buf-move-down)
(bind-key* "C-x <left>" 'buf-move-left)
(bind-key* "C-x <right>" 'buf-move-right)

;; Unbind global unwanted keys
(unbind-key "<insert>")
(unbind-key "<insertchar>")
(unbind-key "C-x C-z")
;; (bind-key* "C-x C-z" 'tst)

;; CUA
(cua-mode t)
(setq cua-keep-region-after-copy nil)
