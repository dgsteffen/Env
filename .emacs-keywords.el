(copy-face 'default 'font-lock-seans-face)
(set-face-foreground 'font-lock-seans-face "DarkGreen")
(set-face-background 'font-lock-seans-face "black")
(setq font-lock-seans-face 'font-lock-seans-face)

(font-lock-add-keywords 'c++-mode
  '(("\\<\\(Get\\(String\\|File\\)\\|\\|Split\\|set_parameters\\|which_flag\\|s_to\\|to_s\\|\\(assign\\(_1p\\|_p\\|ed_numbers\\)\\)\\|file_exists\\|random\\|random_seed\\)\\>" . font-lock-seans-face)
))

(copy-face 'default 'font-lock-sys-routines-face)
(set-face-foreground 'font-lock-sys-routines-face "skyblue")
(set-face-background 'font-lock-sys-routines-face "black")
(setq font-lock-sys-routines-face 'font-lock-sys-routines-face)

(font-lock-add-keywords 'c++-mode
  '(("\\<\\(re\\(move\\|name\\)\\|pow\\|sleep\\|FOREACH\\|\\(open\\|mk\\)dir\\|ctime\\|time\\)\\>" . font-lock-sys-routines-face)
))

(copy-face 'bold 'font-lock-andnotor-face)
(set-face-foreground 'font-lock-andnotor-face "darkorange")
(set-face-background 'font-lock-andnotor-face "black")
(setq font-lock-andnotor-face 'font-lock-andnotor-face)

(font-lock-add-keywords 'c++-mode
  '(("\\<\\(and\\|or\\|not\\|iterator\\|const_iterator\\|nullptr\\)\\>" . font-lock-andnotor-face)
))

(copy-face 'bold 'font-lock-clss-face)
(set-face-foreground 'font-lock-clss-face "magenta")
(set-face-background 'font-lock-clss-face "black")
(setq font-lock-clss-face 'font-lock-clss-face)

(font-lock-add-keywords 'c++-mode
  '(("\\<\\(class\\|struct\\|namespace\\|Numerica\\|Util\\|Solvers\\|Kernel\\|Interface\\)\\>" . font-lock-clss-face)
))

(copy-face 'italic 'font-lock-stream-face)
(set-face-foreground 'font-lock-stream-face "DeepPink")
(set-face-background 'font-lock-stream-face "black")
(setq font-lock-stream-face 'font-lock-stream-face)

(font-lock-add-keywords 'c++-mode
  '(("\\<\\(c\\(out\\|in\\|err\\)\\|\\(str\\|o\\|i\\|if\\|of\\|smart_\\|co\\|ci\\)stream\\|streambuf\\)\\|\\<\\(endl\\)\\>" . font-lock-stream-face)
))
