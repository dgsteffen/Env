; General stuff

(setq default-major-mode 'text-mode)	; new buffers are text mode by default
(setq case-fold-search t)		; make searches case sensitive
(setq scroll-step 1)			; scroll one line off screen
(setq line-number-mode t)		; line numbers always on
(setq column-number-mode t)		; column numbers always on


(setq inhibit-splash-screen t) ; turn off the damned spash screen

(fset 'yes-or-no-p 'y-or-n-p) ; stop forcing me to spell out "yes"

(define-key function-key-map [backspace] "\177")
(define-key function-key-map [delete] "\C-d")


(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq-default auto-fill-hook 'do-auto-fill)

(mouse-wheel-mode t)

(setq-default save-place nil)
(setq save-place nil)

;; turn off toolbar
(tool-bar-mode 0)


;; Don't split the frame when starting with multiple files
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)



(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)


(if window-system
   (progn
      (setq default-frame-alist
	    '((width . 121)
	      (height . 76)
	      (foreground-color . "White")
	      (background-color . "black")
	      (cursor-color . "Green")
	      ))))

;; adjust this path:
;(add-to-list 'load-path "/home/dgsteffen/local/share/emacs")
;(autoload 'compilation-always-kill-mode "compilation-always-kill" nil t)
;(compilation-always-kill-mode 1)


;;;;;;;;;;;;;;;;;; lisp mode

(setq emacs-lisp-mode-hook '(lambda () (font-lock-mode 1)))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; C mode customizations

(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
		("\\.H$"  . c++-mode)
		("\\.cc$" . c++-mode)
		("\\.hh$" . c++-mode)
		("\\.c$"  . c++-mode)
		("\\.t$"  . c++-mode)
		("\\.h$"  . c++-mode)
		("\\.m$"  . matlab-mode)
		("SCon" . python-mode)
		("\\.ln$" . python-mode)
		("scons.config" . python-mode)
		) auto-mode-alist))



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
    )
  "My C++ Programming Style")

(setq indent-tabs-mode nil)

(which-function-mode 1)

(defun my-c-mode-common-hook ()
  (c-add-style "Dave" my-c-style t)
  (c-set-style "Dave")
  (setq c-basic-offset 2)
  (setq font-lock-use-fonts t)
  (setq font-lock-use-colors nil)
  (setq font-lock-use-maximal-decoration t)
  (setq font-lock-auto-fontify t)
  (c-toggle-auto-hungry-state 1)
  (setq show-trailing-whitespace nil)
  (setq indent-tabs-mode nil)
  (set-language-environment '"UTF-8")
  (c-toggle-auto-newline nil)
  (c-set-offset 'namespace-open 0)

  (setq fill-column 100 )

)


;; compiling
(setq  compilation-scroll-output t)


;; (defun compile-pkg (&optional command startdir)
;;   "Compile a package, moving up to the parent directory
;;   containing configure.ac, if it exists. Start in startdir if defined,
;;   else start in the current directory."
;;   (interactive)

;;   (let ((dirname)
;; 	(dir-buffer nil))
;;     (setq startdir (expand-file-name (if startdir startdir ".")))
;;     (setq command  (if command command compile-command))

;;     (setq dirname (upward-find-file "configure.ac" startdir))
;;     (setq dirname (if dirname dirname (upward-find-file "Makefile" startdir)))
;;     (setq dirname (if dirname dirname (expand-file-name ".")))
;;     ; We've now worked out where to start. Now we need to worry about
;;     ; calling compile in the right directory
;;     (save-excursion
;;       (setq dir-buffer (find-file-noselect dirname))
;;       (set-buffer dir-buffer)
;;       (compile command)
;; ;      (kill-buffer dir-buffer)
;;       )))

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

(defun compile-next-makefile ()                                                           
  (interactive)                                                                           
  (let* ((default-directory (or (upward-find-file "mk") "."))                       
         (compile-command (concat "cd " default-directory " && "                          
                                  compile-command)))                                      
    (compile compile-command))) 

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
  (setq fill-column 100 )
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


(fset 'type_include_sys
 "#include <")

(fset 'type_include_norm
 "#include \"")

(fset 'itemz
   [?\\ ?b ?e ?g ?i ?n ?\{ ?i ?t ?e ?m ?i ?z ?e ?\} ?\[ ?< ?+ ?- ?> ?\] return ?\\ ?e ?n ?d ?\{ ?i ?t ?e ?m ?i ?z ?e ?\} ?\C-a return up])

(fset 'vrbtm
   [?\{ ?\\ ?s ?c ?r ?i ?p ?t ?s ?i ?z ?e ?\\ ?b ?e ?g ?i ?n ?\{ ?v ?e ?r ?b ?a ?t ?i ?m ?\} return ?\\ ?e ?n ?d ?\{ ?v ?a ?r backspace backspace ?e ?r ?b ?a ?t ?i ?m ?\} return ?\} left up return up])

(fset 'unused-param
   "/* \346 */")

(fset 'begend
   [?} ?\M-b ?\\ ?b ?e ?g ?i ?n ?{ ?\C-a ?\C-k ?\C-k ?\C-y ?\C-y up ?\M-f ?\M-b delete delete delete delete delete ?e ?n ?d ?\C-a return up])

(global-set-key [(ctrl z)] 'fill-paragraph )
(global-set-key [?\s- ] 'underscore-dammit-str)
(global-set-key [(meta g)] 'goto-line)
(global-set-key [(meta c)] 'delete-indentation       )
(global-set-key "\C-z" 'undo)
;(global-set-key (kbd "C-c v") 'comment-dwim)
;(global-set-key "" nil)

(global-set-key [f1] 'auto-fill-mode		)
(global-set-key [M-f1] 'delete-indentation      )

(global-set-key [S-f1] 'type_include_norm )
(global-set-key [C-f1] 'type_include_sys )

(global-set-key [f2] 'whitespace-cleanup        )
(global-set-key [C-f2] 'nixdos        )

(global-set-key [f3] 'indent-region             )
(global-set-key [C-f3] 'dave-cleanup            )

(global-set-key [f4] 'delete-other-windows      )
(global-set-key [M-f4] 'ctypes-define-type      )

(global-set-key [f5] 'replace-string		)
(global-set-key [M-f5] 'query-replace		)

(global-set-key [f6] 'make-frame-command        )
(global-set-key [C-f6] 'fixup-commit           )
(global-set-key [M-f6] 'center-line             )

;(global-set-key [f7] 'goto-line                 )
(global-set-key [C-f7] 'rgrep                   )
(global-set-key [  f7] 'squash-commit           )
(global-set-key [M-f7] 'font-lock-fontify-buffer)

(global-set-key [f8] 'compile )
(global-set-key [M-f8] 'font-lock-mode          )

(global-set-key [f9] 'next-error                )
(global-set-key [f10] 'goto-line                )

(global-set-key [f11]  'align-regexp  )

(global-set-key [f12] 'call-last-kbd-macro      )



 

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(canlock-password "945e30dda39dadb8c2000ad016d020610315a68e")
 '(case-fold-search t)
 '(compile-command "make ")
 '(cperl-electric-parens-string "\"\"")
 '(cperl-extra-newline-before-brace t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(delete-selection-mode nil nil (delsel))
 '(frame-background-mode (quote dark))
 '(global-font-lock-mode t nil (font-lock))
 '(save-place nil nil (saveplace))
 '(save-place-version-control (quote never))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t nil (paren))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode t)
 '(vc-follow-symlinks nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "grey" :background "black"))))
 '(font-lock-builtin-face ((t (:foreground "cyan"))))
 '(font-lock-constant-face ((t (:foreground "blue"))))
 '(makefile-space-face ((((class color)) (:underline nil :background "red"))))
 '(message-header-subject-face ((((class color) (background light)) (:bold t :italic nil :foreground "red" :background "blue"))) t)
 '(message-header-to-face ((((class color) (background light)) (:bold t :foreground "red" :background "blue"))) t)
 '(message-separator-face ((((class color) (background light)) (:foreground "yellow" :background "blue"))) t))


(setq-default save-place nil)
(setq save-place nil)

;; language

(set-language-environment '"UTF-8")
