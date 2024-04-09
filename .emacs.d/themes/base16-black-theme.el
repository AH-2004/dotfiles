;; base16-tomorrow-night-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/tinted-theming/home)

;;; Authors:
;; Scheme: Chris Kempson (http://chriskempson.com)
;; Template: AH

;;; Code:

(require 'base16-theme)

(defvar base16-black-theme-colors
  '(:base00 "#000000" ;; Background
    :base01 "#161616" ;; Unfocused modeline
    :base02 "#282a2e" ;; Focused modeline
    :base03 "#969896" ;; Comments
    :base04 "#b4b7b4"
    :base05 "#e0e0e0" ;; Focused line numbers
    :base06 "#c5c8c6"
    :base07 "#ffffff"
    :base08 "#e9aeb4"
    :base09 "#c6c693"
    :base0A "#ecc48d"
    :base0B "#cee397"
    :base0C "#7fdbca"
    :base0D "#fbaed2"
    :base0E "#bf94e4"
    :base0F "#c6ad93")
  "All colors for Base16 Black are defined here.")

;; Define the theme
(deftheme base16-black)

;; Add all the faces to the theme
(base16-theme-define 'base16-black base16-black-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-black)

(provide 'base16-black-theme)

;;; base16-black-theme.el ends here
