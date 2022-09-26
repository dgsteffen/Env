

(package-initialize)


;; adjust this path:
(add-to-list 'load-path "/home/dsteffen/Env")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")

(setq default-major-mode 'text-mode)	; new buffers are text mode by default
(setq case-fold-search t)		; make searches case sensitive
(setq scroll-step 1)			; scroll one line off screen
(setq line-number-mode t)		; line numbers always on
(setq column-number-mode t)		; column numbers always on


(setq inhibit-splash-screen t) ; turn off the damned spash screen

(fset 'yes-or-no-p 'y-or-n-p) ; stop forcing me to spell out "yes"
(setq vc-follow-symlinks t)

(define-key function-key-map [backspace] "\177")
(define-key function-key-map [delete] "\C-d")

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq-default auto-fill-hook 'do-auto-fill)

(mouse-wheel-mode t)

(setq-default save-place nil)
(setq save-place nil)

;; Experimental
(global-auto-revert-mode t)


;; turn off bell completely
(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#F2804F")
          (run-with-idle-timer 0.1 nil
                               (lambda (fg) (set-face-foreground 'mode-line fg))
                               orig-fg))))

;; Delete on insertion mode
(delete-selection-mode +1)

(display-time-mode 1)

;; turn off the tool bar
(tool-bar-mode 0)

;; kill the auto save
(setq auto-save-default nil)

;; Hmm -- mouse buffer menu (ctrl-left click)
;; "ctrl - left click" buffer menu: increase number of items shown
;; set max length of this list. default 20. see next.
(setq mouse-buffer-menu-maxlen 30)
;; set # buffer in a mode before grouping begins. takes precedence over previous
;; set to 1 to always group by mode. default 4
(setq mouse-buffer-menu-mode-mult 8)


;; Cause the ron to be highlighted and prevent region-based commands
;; from running when the mark isn't active.

(pending-delete-mode t)
 (setq transient-mark-mode t)

;; Set up proper ANSI colors in compilation windows.
;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region compilation-filter-start (point))
;;   (toggle-read-only))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))


(require 'package)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://www.mirrorservice.org/sites/melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;(require 'protobuf-mode)
(require 'yaml-mode)
(require 'clang-format)
;(require 'groovy-mode)

;(define-key groovy-mode-map (kbd "C-c C-c") 'comment-region)
;(define-key groovy-mode-map (kbd "C-c C-x") 'uncomment-region)

;(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;; Don't split the frame when starting with multiple files
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)

(add-hook 'server-switch-hook
            (lambda ()
              (when (current-local-map)
                (use-local-map (copy-keymap (current-local-map))))
	      (when server-buffer-clients
		(local-set-key (kbd "C-x k") 'server-edit))))


(if window-system
   (progn
      (setq default-frame-alist
	    '((width . 123)
	      (height . 45)
	      (foreground-color . "White")
	      (background-color . "black")
	      (cursor-color . "Green")
	      ))))

;(set-face-foreground 'modeline "yellow")
;(set-face-background 'modeline "purple")
;(set-face-background 'modeline-inactive "light blue")

;; Use C-x k to kill buffers for emacsclients
;; (add-hook 'server-switch-hook
;;             (lambda ()
;;               (when (current-local-map)
;;                 (use-local-map (copy-keymap (current-local-map))))
;; 	      (when server-buffer-clients
;; 		(local-set-key (kbd "C-x k") 'server-edit))))


;(autoload 'compilation-always-kill-mode "compilation-always-kill" nil t)
;(compilation-always-kill-mode 1)


;;;;;;;;;;;;;;;;;; lisp mode

(setq emacs-lisp-mode-hook '(lambda () (font-lock-mode 1)))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; show parens
(show-paren-mode t)

;; C mode customizations
(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
(autoload 'cmake-mode "cmake-mode" "CMakeFile Editing Mode" t)
(setq auto-mode-alist
      (append '(("\\.C\\'" . c++-mode)
                ("\\.cc\\'" . c++-mode)
                ("\\.cpp\\'" . c++-mode)
                ("\\.cs\\'" . c++-mode)
                ("\\.ii\\'" . c++-mode)
                ("\\.c\\'" . c++-mode)
                ("\\.h\\'"  . c++-mode)
                ("\\.hxx\\'"  . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.hh$" . c++-mode)
                ("\\.c$"  . c++-mode)
                ("\\.t$"  . c++-mode)
                ("\\.h$"  . c++-mode)
                ("\\.cu$" . c++-mode)
                ("\\.pl$" . cperl-mode)
                ("\\.proto" . protobuf-mode)
                ("makefile" . makefile-mode)
                ("CMakeLists\\.txt" . cmake-mode)
                ("\\.cmake" . cmake-mode)
                ("\\.yml" . yaml-mode)
                )
              auto-mode-alist)
      )

(setq-default indent-tabs-mode nil)

(which-function-mode 1)

(setq make-backup-files nil)

(setq python-fill-docstring-style 'DJANGO)


(defconst my-c-style
  '(
    (c-tab-always-indent       . t)
    (c-hanging-braces-alist    . ((substatement-open after)
				  (brace-list-open)
				  (class-open after)
				  (class-close)
				  (inline-open)
				  (inline-close)))
    (c-hanging-colons-alist    . ((member-init-intro)
				  (inher-intro)
				  (case-label after)
				  (access-label after)))
    (c-cleanup-list            . ((brace-else-brace)
				  (brace-elseif-brace)
				  (defun-close-semi)
				  (scope-operator)))
    (c-offsets-alist . ((innamespace . [0])))

    )
  "My C++ Programming Style")

(setq indent-tabs-mode nil)





(defun my-c-mode-common-hook ()
  (c-add-style "Dave" my-c-style t)
  (c-set-style "Dave")
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'inline-open 0)
  (setq c-basic-offset 4)
  (setq font-lock-use-fonts t)
  (setq font-lock-use-colors nil)
  (setq font-lock-use-maximal-decoration t)
  (setq font-lock-auto-fontify t)
  (c-toggle-auto-hungry-state 1)
  (setq show-trailing-whitespace nil)
  (setq indent-tabs-mode nil)
  (set-language-environment '"UTF-8")
  (c-toggle-auto-newline nil)
  (c-set-offset 'namespace-open -4)

  (setq fill-column 100 )

)

(defconst my-protobuf-style
  '((c-basic-offset . 4)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" my-protobuf-style t)))




(setq python-fill-docstring-style 'DJANGO)




;;compiling


(setq  compilation-scroll-output t)


(defun compile-pkg (&optional command startdir)
  "Compile a package, moving up to the parent directory
  containing configure.ac, if it exists. Start in startdir if defined,
  else start in the current directory."
  (interactive)

  (let ((dirname)
	(dir-buffer nil))
    (setq startdir (expand-file-name (if startdir startdir ".")))
    (setq command  (if command command compile-command))

    (setq dirname (upward-find-file "configure.ac" startdir))
    (setq dirname (if dirname dirname (upward-find-file "Makefile" startdir)))
    (setq dirname (if dirname dirname (expand-file-name ".")))
    ; We've now worked out where to start. Now we need to worry about
    ; calling compile in the right directory
    (save-excursion
      (setq dir-buffer (find-file-noselect dirname))
      (set-buffer dir-buffer)
      (compile command)
;      (kill-buffer dir-buffer)
      )))

(defun upward-find-file (filename &optional startdir)
  "Move up directories until we find a certain filename. If we
  manage to find it, return the containing directory. Else if we
  get to the toplevel directory and still can't find it, return
  nil. Start at startdir or . if startdir not given"

  (let ((dirname (expand-file-name
		  (if startdir startdir ".")))
	(found nil) ; found is set as a flag to leave loop if we find it
	(top nil))  ; top is set when we get
		    ; to / so that we only check it once

    ; While we've neither been at the top last time nor have we found
    ; the file.
    (while (not (or found top))
      ; If we're at / set top flag.
      (if (string= (expand-file-name dirname) "/")
	  (setq top t))
      
      ; Check for the file
      (if (file-exists-p (expand-file-name filename dirname))
	  (setq found t)
	; If not, move up a directory
	(setq dirname (expand-file-name ".." dirname))))
    ; return statement
    (if found dirname nil)))


setq(dave-build-dir "build")

(defun compile-next-makefile ()                                                           
  (interactive)                                                                           
  (let* ((default-directory (or (upward-find-file "build") "."))                       
         (compile-command (concat "cd " default-directory "/build && "                          
                                  compile-command)))                                      
    (compile compile-command))) 

(setq compile-command "docker exec -w ${PWD} -t dude ninja")

(defun std-compile ()
  "Like 'compile', but uses compile-pkg"
  (interactive)
  (compile-pkg compile-command))



;; no tabs in indentation
(defun my-build-tab-stop-list (width)
  (let ((num-tab-stops (/ 80 width))
	(counter 1)
	(ls nil))
    (while (<= counter num-tab-stops)
      (setq ls (cons (* width counter) ls))
      (setq counter (1+ counter)))
    (set (make-local-variable 'tab-stop-list) (nreverse ls))))




(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c-mode-common-hook 'turn-on-auto-fill)

;; Make the compilation window go away after successful builds
(setq compilation-finish-function
      (lambda (buf str)

	(if (string-match "exited abnormally" str)

	    ;;there were errors
	    (message "compilation errors, press C-x ` to visit")

	  ;;no errors, make the compilation window go away in 0.5 seconds
	  (run-at-time 0.5 nil 'delete-windows-on buf)
	  (message "NO COMPILATION ERRORS!"))))


(load "~/.emacs-ctypes")
;(ctypes-read-file "~/.emacs-types" )
;(setq ctypes-write-types-at-exit "~/.emacs-types")
(load "~/.emacs-keywords")
(load "~/.emacs-colors")

(defun my-perl-mode-hook ()
  (font-lock-mode)
  (auto-fill-mode)
)

(add-hook 'perl-mode-hook 'my-perl-mode-hook)
(add-hook 'perl-mode--hook 'turn-on-auto-fill)

(add-hook 'python-mode-hook 'my-python-mode-hook)
(add-hook 'python-mode--hook 'turn-on-auto-fill)

(defun my-python-mode-hook ()
;  (setq python-indent 2)
  (setq fill-column 80 )
  (setq-default indent-tabs-mode nil)
)


(fset 'indent-file
   [C-home ?\C-  C-end ?\M-x ?i ?n ?d ?e ?n ?t ?- ?r ?e ?g tab return])

(fset 'indent-save
   [M-f2 ?\C-x ?\C-s])

;; (fset 'underscore-dammit-str
;;    "_")


(fset 'cleanup-file
   [?\M-x ?i ?n ?d ?e ?n ?t ?- ?f ?i ?l ?e return ?\M-x ?w ?h ?i ?t ?e ?s ?p ?a ?c ?e ?- ?c ?l ?e ?a ?n ?u ?p return])

;(if "~/.customs.emacs"
;    (load "~/.customs.emacs" t t))

;; Art: added with v. 23.1 to make spacebar complete filenames (8/17/2009)
(progn
 (define-key minibuffer-local-completion-map " " 'minibuffer-complete-word)
 (define-key minibuffer-local-filename-completion-map " " 'minibuffer-complete-word)
 (define-key minibuffer-local-must-match-filename-map " " 'minibuffer-complete-word))


(defun dave-cleanup ()
  "indent, untabify, whitespace cleanup"
  (interactive)
;  (push-mark (point))
;  (push-mark (point-max) nil t)
  ( indent-region (point-min) (point-max) nil)
  ( untabify (point-min) (point-max))
  ( whitespace-cleanup)
)

(fset 'squash-commit
   [?\C-a delete delete delete delete ?s left down])

(fset 'fixup-commit
   [?\C-a delete delete delete delete ?f left down])

(fset 'nixdos
   [?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?s ?t ?r ?i ?n ?g return ?\C-q ?\C-m return return ?\C-x])


(fset 'itemz
   [?\\ ?b ?e ?g ?i ?n ?\{ ?i ?t ?e ?m ?i ?z ?e ?\} ?\[ ?< ?+ ?- ?> ?\] return ?\\ ?e ?n ?d ?\{ ?i ?t ?e ?m ?i ?z ?e ?\} ?\C-a return up])

(fset 'vrbtm
   [?\{ ?\\ ?s ?c ?r ?i ?p ?t ?s ?i ?z ?e ?\\ ?b ?e ?g ?i ?n ?\{ ?v ?e ?r ?b ?a ?t ?i ?m ?\} return ?\\ ?e ?n ?d ?\{ ?v ?a ?r backspace backspace ?e ?r ?b ?a ?t ?i ?m ?\} return ?\} left up return up])

(fset 'unused-param
   "/* \346 */")

(fset 'begend
   [?} ?\M-b ?\\ ?b ?e ?g ?i ?n ?{ ?\C-a ?\C-k ?\C-k ?\C-y ?\C-y up ?\M-f ?\M-b delete delete delete delete delete ?e ?n ?d ?\C-a return up])





(global-set-key [?\s- ] 'underscore-dammit-str)
(global-set-key [(meta g)] 'goto-line)
(global-set-key [(meta c)] 'delete-indentation       )
(global-set-key "\C-z" 'undo)

(global-set-key [mouse-8] 'mouse-buffer-menu)

(global-set-key (kbd "C-c C-x") 'comment-region)
(global-set-key (kbd "C-c C-z") 'uncomment-region)

(global-set-key [C-z] 'undo )

(global-set-key [(ctrl \;)] 'dabbrev-expand )

;(bind-key "C-+" 'text-scale-increase)
;(bind-key "C-_" 'text-scale-decrease)


(global-set-key [f1] 'auto-fill-mode		)
(global-set-key [M-f1] 'delete-indentation      )
(global-set-key [(shift f1)] 'org-mode          )


(global-set-key [f2] 'whitespace-cleanup        )
(global-set-key [C-f2] 'nixdos        )

(global-set-key [f3] 'indent-region             )
(global-set-key [C-f3] 'dave-cleanup            )
(global-set-key [M-f3] 'clang-format-buffer     )

(global-set-key [f4] 'delete-other-windows      )
(global-set-key [C-f4] 'ctypes-define-type      )
(global-set-key [M-f4] 'clang-format-region     )

(global-set-key [f5] 'replace-string		)
(global-set-key [M-f5] 'query-replace		)
(global-set-key [C-f5] 'query-replace		) ; because RH / gnome?

(global-set-key [f6] 'make-frame-command        )
(global-set-key [C-f6] 'fixup-commit           )
(global-set-key [M-f6] 'center-line             )

;(global-set-key [f7] 'goto-line                 )
(global-set-key [C-f7] 'rgrep                   )
(global-set-key [  f7] 'squash-commit           )
(global-set-key [M-f7] 'font-lock-fontify-buffer)

(global-set-key [f8] 'compile-next-makefile )
(global-set-key [M-f8] 'font-lock-mode          )

(global-set-key [f9] 'next-error                )
(global-set-key [f10] 'goto-line                )

(global-set-key [f11]  'align-regexp  )

(global-set-key [f12] 'call-last-kbd-macro      )


(global-set-key [?\s-\H- ] 'underscore-dammit-str)



