;; base16-apprentice-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/tinted-theming/home)

;;; Authors:
;; Scheme: Chris Kempson (http://chriskempson.com)
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

;; PINK FC0FC0
;; RED E198B2

(defvar base16-apprentice-theme-colors
  '(:base00 "#262626" ;; Correct
    :base01 "#1C1C1C" ;; Correct
    :base02 "#373b41"
    :base03 "#6C6C6C"
    :base04 "#5F87AF"
    :base05 "#BCBCBC"
    :base06 "#E198B2"
    :base07 "#6C6C6C"
    :base08 "#BCBCBC"
    :base09 "#FF8700"
    :base0A "#8787AF" ;; Correct
    :base0B "#87AF87"
    :base0C "#87AFD7"
    :base0D "#5f8787"
    :base0E "#5FAFAF"
    :base0F "#BCBCBC")
  "All colors for Base16 Apprentice are defined here.")

;; Define the theme
(deftheme base16-apprentice)

;; Add all the faces to the theme
(base16-theme-define 'base16-apprentice base16-apprentice-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-apprentice)

(provide 'base16-apprentice-theme)

;;; base16-apprentice-theme.el ends here
