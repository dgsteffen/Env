;; line at bottom telling file name etc...
(copy-face 'bold 'modeline)
(set-face-foreground 'modeline "goldenrod")
(set-face-background 'modeline "midnight blue")

(set-background-color "black")

;; comments
(copy-face 'italic  'font-lock-comment-face)
(set-face-foreground 'font-lock-comment-face "magenta")
(set-face-background 'font-lock-comment-face "black")
(setq font-lock-comment-face 'font-lock-comment-face)


(copy-face 'default 'show-paren-mismatch-face)
(set-face-foreground 'show-paren-mismatch-face "black")
(set-face-background 'show-paren-mismatch-face "red")
(setq show-paren-mismatch-face 'show-paren-mismatch-face)

(copy-face 'default  'font-lock-emphasized-face)
(set-face-foreground 'font-lock-emphasized-face "blue")
(set-face-background 'font-lock-emphasized-face "black")
(setq font-lock-string-face 'font-lock-emphasized-face)

;; stuff in quotes
(copy-face 'italic  'font-lock-other-emphasized-face)
(set-face-foreground 'font-lock-other-emphasized-face "blue")
(set-face-background 'font-lock-other-emphasized-face "black")
(setq font-lock-string-face 'font-lock-other-emphasized-face)

;; keywords (class, const, for, if, etc...)
(copy-face 'bold 'font-lock-keyword-face)
(set-face-foreground 'font-lock-keyword-face "yellow")
(set-face-background 'font-lock-keyword-face "black")
(setq font-lock-keyword-face 'font-lock-keyword-face)

;; function names
(copy-face 'bold 'font-lock-function-name-face)
(set-face-foreground 'font-lock-function-name-face "cyan")
(set-face-background 'font-lock-function-name-face "black")
(setq font-lock-function-name-face 'font-lock-function-name-face)

;; variable names
(copy-face 'default 'font-lock-variable-name-face)
(set-face-foreground 'font-lock-variable-name-face "green")
(set-face-background 'font-lock-variable-name-face "black")
(setq font-lock-variable-name-face 'font-lock-variable-name-face)

;; type colors (i.e. int, float, etc...)
(copy-face 'bold  'font-lock-type-face)
(set-face-foreground 'font-lock-type-face "goldenrod")
(set-face-background 'font-lock-type-face "black")
(setq font-lock-type-face 'font-lock-type-face)

;; ??
(copy-face 'bold  'font-lock-reference-face)
(set-face-foreground 'font-lock-reference-face "yellow")
(set-face-background 'font-lock-reference-face "Blue")
(setq font-lock-reference-face 'font-lock-reference-face)


(set-face-foreground 'highlight "yellow")
(set-face-background 'highlight "red")

;; highlighted region
(set-face-foreground 'region "yellow")
(set-face-background 'region "darkviolet")

(set-face-foreground 'secondary-selection "white")
(set-face-background 'secondary-selection "darkviolet")

(copy-face 'bold  'show-paren-match-face)
(set-face-foreground 'show-paren-match-face "yellow1")
(set-face-background 'show-paren-match-face "mediumorchid4")

(set-face-foreground 'show-paren-mismatch-face "yellow")
(set-face-background 'show-paren-mismatch-face "firebrick1")
