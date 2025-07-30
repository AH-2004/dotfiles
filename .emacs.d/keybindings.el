;; Sidebar
(bind-key* "C-S-k" 'neotree-toggle)
(bind-key "S-<return>" 'neotree-change-root neotree-mode-map)
(bind-key "<deletechar>" 'neotree-delete-node neotree-mode-map)
(bind-key "<f2>" 'neotree-rename-node neotree-mode-map)

;; Zoom
(bind-key* "C-=" 'text-scale-increase)
(bind-key* "C--" 'text-scale-decrease)
(bind-key* "C-0" 'text-scale-reset)

;; Alpha
(bind-key* "C-+" 'alpha-increase)
(bind-key* "C-_" 'alpha-decrease)
(bind-key* "C-)" 'alpha-reset)

;; Toggle line numbers
(bind-key* "C-S-g" 'display-line-numbers-toggle)

;; Move lines
(bind-key* "C-S-<up>" 'drag-stuff-up)
(bind-key* "C-S-<down>" 'drag-stuff-down)

;; Multiple Cursors
(bind-key* "M-<down>" 'mc/mark-next-like-this)
(bind-key* "M-S-<up>" 'mc/unmark-next-like-this)
(bind-key* "M-<up>" 'mc/mark-previous-like-this)
(bind-key* "M-S-<down>" 'mc/unmark-previous-like-this)
(bind-key* "M-<mouse-2>" 'mc/add-cursor-on-click)

;; Completions
(bind-key* "C-SPC" 'completion-at-point)
;; (bind-key* "C-SPC" 'lsp-bridge-popup-complete-menu)

;; Comments
(bind-key* "C-/" 'comment)

;; Mark
(bind-key* "C-a" 'mark-whole-buffer)
(bind-key* "C-x SPC" 'set-mark-command)

;; Copy/Paste/Cut
(bind-key* "C-c C-v" 'duplicate-line)

;; Delete line
(bind-key* "S-<delete>" 'delete-line)

;; Delete word
(bind-key* "C-<backspace>" 'backward-delete-word)
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
(bind-key* "C-S-n" 'dired-create-directory)
(bind-key* "C-x C-d" 'dired-jump)
(bind-key "<deletechar>" 'dired-do-delete dired-mode-map)
(bind-key "<f2>" 'dired-do-rename dired-mode-map)
(bind-key "<mouse-2>" 'dired-find-file dired-mode-map)
(bind-key "C-x C-s" 'wdired-finish-edit wdired-mode-map)
(bind-key "S-<return>" 'dired-up-directory dired-mode-map)

;; Org mode
(bind-key "<backtab>" 'org-src-block org-mode-map)
(bind-key "C-c C-w" 'org-toggle-checkbox-wip org-mode-map)

;; Terminal
(bind-key* "C-x t" 'term)

;; Bookmarks
;; (bind-key* "C-x v" 'bookmark-bmenu-list)
;; (bind-key* "C-x C-v" 'bookmark-bmenu-list)
;; (bind-key "<deletechar>" 'bookmark-delete bookmark-bmenu-mode-map)
(bind-key* "C-x v" 'bookmarks)
(bind-key* "C-x C-v" 'bookmarks)

;; Ibuffer
(bind-key "<deletechar>" 'ibuffer-do-delete ibuffer-mode-map)

;; Buffers and windows
(bind-key* "C-x k" 'kill-buffer)
(bind-key* "C-x r" 'rename-buffer)
(bind-key* "C-x C-b" 'ibuffer)
(bind-key* "C-x <up>" 'buf-move-up)
(bind-key* "C-x <down>" 'buf-move-down)
(bind-key* "C-x <left>" 'buf-move-left)
(bind-key* "C-x <right>" 'buf-move-right)
(bind-key* "C-<tab>" 'other-window)
(bind-key* "C-<iso-lefttab>" 'other-window-back)
(bind-key* "C-x 4" 'clone-indirect-buffer-other-window)
(bind-key* "M-<home>" 'beginning-of-buffer)
(bind-key* "M-<end>" 'end-of-buffer)
(bind-key* "M-<prior>" 'beginning-of-buffer)
(bind-key* "M-<next>" 'end-of-buffer)
(bind-key* "<escape>" 'keyboard-escape-quit)
(bind-key* "C-<prior>" 'enlarge-window-horizontally)
(bind-key* "C-S-<prior>" 'enlarge-window)
(bind-key* "C-<next>" 'shrink-window-horizontally)
(bind-key* "C-S-<next>" 'shrink-window)

;; Miscellaneous
(bind-key* "C-x C-z" 'tst)
(bind-key* "C-x C-z" 'kmacro-call-macro)

;; Unbind from mode-map
(local-unset-key (vector asm-comment-char))

;; Unbind global unwanted keys
(unbind-key "<insert>")
(unbind-key "<insertchar>")
(unbind-key "S-<down-mouse-1>")
(unbind-key "C-<down-mouse-1>")
(unbind-key "C-<down-mouse-3>")
(unbind-key "<mouse-2>")
(unbind-key "C-x C-z")

;; CUA
(cua-mode t)
