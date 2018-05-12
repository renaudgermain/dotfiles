;(defvar cssm-version "0.11.zap1" "The current version number of css-mode.")

; To install, put this in your .emacs:
;
; (autoload 'css-mode "css-mode")
; (setq auto-mode-alist       
;      (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;; TODO
;; - finish indentation
;; - fix comment highlighting
;; - prettier regexp in general \\w instead of [a-zA-Z_]

;; Required modules
(require 'apropos)
(require 'font-lock)
(require 'cl)

(add-to-list 'auto-mode-alist '("\\.bel\\'" . beluga-mode))
(add-to-list 'auto-mode-alist '("\\.rec\\'" . beluga-mode))

;;; The code itself

; Customizable variables:

; (defvar cssm-indent-level 2 "The indentation level inside rules.")
; (defvar cssm-mirror-mode t "Whether brackets, quotes etc should be mirrored automatically on insertion.")
; (defvar cssm-newline-before-closing-bracket nil "In mirror-mode, controls whether a newline should be inserted before the closing bracket or not.")
; (defvar cssm-indent-function #'cssm-old-style-indenter "Which function to use when deciding which column to indent to. To get C-style indentation, use cssm-c-style-indenter. To get old-style indentation, use cssm-old-style-indenter.")

; The rest of the code:

; (defvar cssm-properties
;   '("font-family" "font-style" "font-variant" "font-weight" "font-size"
;     "font" "background-color" "background-image" "background-repeat"
; 
;     ; Non-standard properties
;     "cell-spacing" "column-span" "row-span" "speak-date" "speak-time")
;   "A list of all CSS properties.")
; 
; (defvar cssm-properties-alist
;   (mapcar (lambda(prop)
; 	    (cons (concat prop ":") nil)) cssm-properties)
;   "An association list of the CSS properties for completion use.")
; 
; (defvar cssm-keywords 
;   (append '("!\\s-*important"
; 	  ; CSS level 2:
; 	    "@media" "@import" "@page" "@font-face")
; 	  (mapcar (lambda(property)
; 		    (concat property "\\s-*:"))
; 		  cssm-properties))
;   "A list of all CSS keywords.")
; 
; (defvar cssm-pseudos
;   '("link" "visited" "active" "first-line" "first-letter"
; 
;     ; CSS level 2
;     "first-child" "before" "after" "hover" "focus" "lang")
;   "A list of all CSS pseudo-classes.")
; 
; ; internal
; (defun cssm-list-2-regexp(altlist)
;   "Takes a list and returns the regexp \\(elem1\\|elem2\\|...\\)"
;   (let ((regexp "\\("))
;     (mapcar (lambda(elem)
; 	      (setq regexp (concat regexp elem "\\|")))
; 	    altlist)
;     (concat (substring regexp 0 -2) ; cutting the last "\\|"
; 	    "\\)")
;     ))

(defvar beluga-font-lock-keywords
  (list
   ;;   (regexp-opt '("rec" "case" "FN" "mlam" "box" "sbox" "of" "type" "let" "in" "end" "schema" "pack") t), optimized
   ;; (list "\\<rec\\s-+\\(\\sw+\\)" (1 font-lock-function-name-face))


   (list "\\(%.*$\\)"                                   1 font-lock-comment-face)
   (list "^[\t ]*\\([a-zA-Z]+[a-zA-Z0-9_]*\\)[\t ]*:"   1 font-lock-constant-face)
   ;;(list "[^a-zA-Z_]\\(Sigma\\|fn\\|FN\\|box\\|case\\|end\\|in\\|type\\|let\\|mlam\\|of\\|id\\|pack\\|rec\\|s\\(?:box\\|chema\\)\\)\\>" 1 font-lock-keyword-face)
   (list "\\<\\(Sigma\\|fn\\|FN\\|box\\|case\\|end\\|in\\|fst\\|snd\\|type\\|let\\|mlam\\|of\\|id\\|pack\\|rec\\|some\\|block\\|s\\(?:box\\|chema\\)\\)\\>" 1 font-lock-keyword-face)
   (list "\\<rec[ \t]+\\([a-zA-Z]+[a-zA-Z0-9_]*\\)" 1 font-lock-function-name-face)
   (list "\\(FN\\|mlam\\|fn\\)[ \t]+\\([a-zA-Z_]+\\)"   2 font-lock-variable-name-face)
   (list "\\([a-zA-Z]+[a-zA-Z0-9_]*\\):"                1 font-lock-variable-name-face)
   (list "[\\]\\([a-zA-Z]+[a-zA-Z0-9_]*\\)"             1 font-lock-variable-name-face)
   (list "\\<id[(]\\([a-zA-Z]+[a-zA-Z0-9_]*\\)[)]"      1 font-lock-variable-name-face)
   (list "[[<{(]\\([a-zA-Z]+[a-zA-Z0-9_]*\\)[ \t]*[,.]" 1 font-lock-variable-name-face)
   (list "\\[\\([a-zA-Z]+[a-zA-Z0-9_]*\\)\\]"           1 font-lock-variable-name-face)
   (list ":[\t ]*\\([a-zA-Z]+[a-zA-Z0-9_]*\\)"          1 font-lock-type-face)
   (list "\\(->\\)" 1 font-lock-builtin-face)
   )
   ;; TODO be more rigorous about regexp, highlight different kind of variable with different colors

   ;; font-lock-(warning|function-name|variable-name|keyword|builtin|
   ;;            comment|constant|type|string|doc|preprocessor|reference)-face

  "Rules for highlighting Beluga programs.")

(defvar beluga-mode-map ()
  "Keymap used in Beluga mode.")
(when (not beluga-mode-map)
  (setq beluga-mode-map (make-sparse-keymap))
;  (define-key cssm-mode-map (read-kbd-macro "C-c C-c") 'cssm-insert-comment)
;  (define-key cssm-mode-map (read-kbd-macro "C-c C-u") 'cssm-insert-url)
;  (define-key cssm-mode-map (read-kbd-macro "}") 'cssm-insert-right-brace-and-indent)
;  (define-key cssm-mode-map (read-kbd-macro "M-TAB") 'cssm-complete-property)
)

; ;;; Cross-version compatibility layer
; 
; (when (not (or (apropos-macrop 'kbd)
; 	     (fboundp 'kbd)))
;     (defmacro kbd (keys)
;       "Convert KEYS to the internal Emacs key representation.
; KEYS should be a string constant in the format used for
; saving keyboard macros (see `insert-kbd-macro')."
;       (read-kbd-macro keys)))

(defun beluga-indent-line()
  "Indents the current line."
  (interactive)
  (beginning-of-line)

  (if (bobp)
      (indent-line-to 0)
    (let ((curr 0))
      (progn
        ;; look at previous line if there is something notable
        (forward-line -1)
        (cond
         ((looking-at "^[ \t]*\\<rec\\>") 
          (setq curr (+ (current-indentation) default-tab-width)))
         ((looking-at ".*\\<\\(of\\|let\\|mlam\\|FN\\|fn\\|in\\)\\>.*")
          (setq curr (+ (current-indentation) default-tab-width)))
         ((looking-at "^[ \t]*|")
          (setq curr (+ (current-indentation) 2)))
         (t                         (setq curr (current-indentation))))
        (forward-line 1)

        ;; look at current line to take a final decision
        (progn
          (if (looking-at "^[ \t]*|") (setq curr (- curr 2)))
          (if (looking-at ".*\\<in\\>.*") (setq curr (- curr default-tab-width)))
          (if (looking-at ".*\\<end\\>.*") (setq curr (- curr default-tab-width)))
          (indent-line-to curr)
        )))))

;; signature: if "const: ..." augment indent, ends with "... ."

;; augment indent: =>, rec, of, let, =
;; back one level of indent: in, "|"
;; reduce one level of indent: end
;; reset indent: ";"
;; open a new fixed level (, [, {, <

;; BELUGA actually stands for BindErs, meta-LangUaGe and hoAs

(defun beluga-mode()
  "Major mode for editing Beluga programs.
\\{beluga-mode-map}"
  (interactive)

  ;; Initializing
  (kill-all-local-variables)

  ;; Setting up indentation handling
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'beluga-indent-line)

  ;; Setting up font-locking
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(beluga-font-lock-keywords nil t nil nil))

  ;; Setting up typing shortcuts
;  (make-local-variable 'skeleton-end-hook)
;  (setq skeleton-end-hook nil)
  
  (use-local-map beluga-mode-map)
  
  ; Setting up syntax recognition
;; crap, erase following
;;  (make-local-variable 'comment-start)
;;  (make-local-variable 'comment-end)
;;  (make-local-variable 'comment-start-skip)
;;
;;  (setq comment-start "(*"
;;        comment-end "*)"
;;        comment-start-skip "/\\*[ \n\t]+")

  ;; Setting up syntax table
;  (modify-syntax-entry ?* ". 23")
;  (modify-syntax-entry ?/ ". 14")
  
  ;; Final stuff, then we're done
  (setq mode-name "Beluga"
	major-mode 'beluga-mode)
  (run-hooks 'beluga-mode-hook))

(provide 'beluga-mode)

;; Beluga-mode ends here
