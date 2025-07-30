;;; openwith.el --- Open files with external programs

;; Copyright (C) 2007  Markus Triska
;; Copyright (C) 2024  Lou Woell <lou.woell@posteo.de>

;; Author: Markus Triska <markus.triska@gmx.at>
;; Keywords: files, processes
;; URL: https://git.repetitions.de/openwith
;; Version: 20241118.1

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This lets you associate external applications with files so that
;; you can open them via C-x C-f, with RET in Dired, etc.

;; Copy openwith.el to your load-path and add to your .emacs:

;;    (require 'openwith)
;;    (openwith-mode t)

;; To customize associations etc., use:

;;    M-x customize-group RET openwith RET

;;; Code:

(defgroup openwith nil
  "Associate external applications with file name patterns."
  :group 'files
  :group 'processes)

(defcustom openwith-associations
  '(("\\.pdf\\'" "acroread" (file))
    ("\\.mp3\\'" "xmms" (file))
    ("\\.\\(?:mpe?g\\|avi\\|wmv\\)\\'" "mplayer" ("-idx" file))
    ("\\.\\(?:jp?g\\|png\\)\\'" "display" (file)))
  "Associations of file patterns to external programs.

File pattern is a regular expression describing the files to
associate with a program. The program arguments are a list of
strings and symbols and are passed to the program on
invocation,where the symbol 'file' is replaced by the file to be
opened."
  :group 'openwith
  :type '(repeat (list (regexp :tag "Files")
                       (string :tag "Program")
                       (sexp :tag "Parameters"))))

(defcustom openwith-confirm-invocation nil
  "Ask for confirmation before invoking external programs."
  :group 'openwith
  :type 'boolean)

(defun openwith-make-extension-regexp (strings)
  "Make a regexp that matches a string that starts with a '.', has
any of the supplied STRINGS, and is at the end of the string."
  (concat "\\." (regexp-opt strings) "$"))

(defun openwith/make-assocs (alist)
  "Transforms an ALIST of file types and programms into a valid list
for `openwith-associations'.

The elements in ALIST should have exactly three elements:

1. A list of strings to be transformed into regexps with
`openwith-make-extension-regexp'.

2. The programm to associate the regexp with as a string.

3. A list of arguments for the programm. The position of the
filepath is indicated by the symbol `file'."

  (mapcar '(lambda (x) (let ((strings (car x))
                        (programm (cdr x)))
                    (cons (openwith-make-extension-regexp strings)
                          programm)))
          alist))

(defun openwith-open-unix (command arglist)
  "Run external command COMMAND, in such a way that it is disowned
from the parent Emacs process. If Emacs dies, the process spawned
here lives on. ARGLIST is a list of strings,each an argument to
COMMAND."
  (let ((shell-file-name "/bin/sh"))
    (start-process-shell-command
     "openwith-process" nil
     (concat
      "exec nohup " command " "
      (mapconcat 'shell-quote-argument arglist " ")
      " >/dev/null"))))

(defun openwith-open-windows (file)
  "Run external command COMMAND, in such a way that it is disowned
from the parent Emacs process. If Emacs dies, the process spawned
here lives on. ARGLIST is a list of strings,each an argument to
COMMAND."
  (w32-shell-execute "open" file))


(defun openwith/find-file (filename &rest rest)
  "Open FILENAME in Programm according to `openwith-associations'.

This is intended to be used as advice to `find-file'."
  (when-let ((filepath (expand-file-name filename))
             (oa (assoc filepath openwith-associations 'string-match-p))
             (program (cadr oa))
             (params (mapcar (lambda (x) (if (eq x 'file) filepath x))
                             (nth 2 oa))))
    (when (or (not openwith-confirm-invocation)
              (y-or-n-p (format "Open %s in %s?" filename program)))
      (if (eq system-type 'windows-nt) (openwith-open-windows filepath)
               (openwith-open-unix program params))
      (when (featurep 'recentf) (recentf-add-file filepath))
      (message (format "Opened %s in external program"
                       (file-name-nondirectory filepath))))))


;;;###autoload
(define-minor-mode openwith-mode
  "Automatically open files with external programs."
  :lighter ""
  :global t
  (if openwith-mode
      (progn
        (advice-add 'find-file :before-until 'openwith/find-file)
        (advice-add 'org-open-file :before-until 'openwith/find-file))
    (progn
      (advice-remove 'find-file 'openwith/find-file)
      (advice-remove 'org-open-file 'openwith/find-file))))


(provide 'openwith)
;;; openwith.el ends here
