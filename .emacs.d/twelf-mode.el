;(defvar cssm-version "0.11.zap1" "The current version number of css-mode.")

;; Required modules
(require 'apropos)
(require 'font-lock)
(require 'cl)

(add-to-list 'auto-mode-alist '("\\.elf\\'" . twelf-mode))

(defvar twelf-font-lock-keywords
  (list
   ;; (list "\\<rec\\s-+\\(\\sw+\\)" (1 font-lock-function-name-face))
   
   ;; (regexp-opt '("%abbrev" "%infix" "%prefix" "%postfix" "%name" "%query" "%clause" "%tabled" "%querytabled"
   ;;               "%deterministic" "%mode" "%terminates" "%recudes" "%block" "%worlds" "%total" "%freeze"
   ;;               "%theorem" "%prove" "%establish" "%assert" "%use" "%solve" "%define" "%covers"))

   (list "%\\(?:a\\(?:bbrev\\|ssert\\)\\|block\\|c\\(?:lause\\|overs\\)\\|de\\(?:fine\\|terministic\\)\\|establish\\|freeze\\|infix\\|mode\\|name\\|p\\(?:ostfix\\|r\\(?:efix\\|ove\\)\\)\\|query\\(?:tabled\\)?\\|recudes\\|solve\\|t\\(?:abled\\|erminates\\|heorem\\|otal\\)\\|use\\|worlds\\)"
         1 font-lock-builtin-face)
   (list "\\(% .*$\\|%%.*$\\)"                          1 font-lock-comment-face)
   (list "^[\t ]*\\([a-zA-Z]+[a-zA-Z0-9_]*\\)[\t ]*:"   1 font-lock-constant-face)
   (list "\\([A-Z]+[a-zA-Z0-9_]*\\):"                   1 font-lock-variable-name-face)
   )

  "Rules for highlighting Twelf programs.")

(defvar twelf-mode-map ()
  "Keymap used in Twelf mode.")
(when (not twelf-mode-map)
  (setq twelf-mode-map (make-sparse-keymap)))

(defun twelf-indent-line()
  "Indents the current line."
  (interactive)
  (beginning-of-line)

  (if (bobp)
      (indent-line-to 0)
    (let ((curr 0))
      (indent-line-to curr))))


(defun twelf-mode()
  "Major mode for editing Twelf programs.
\\{twelf-mode-map}"
  (interactive)

  ;; Initializing
  (kill-all-local-variables)

  ;; Setting up indentation handling
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'twelf-indent-line)

  ;; Setting up font-locking
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(twelf-font-lock-keywords nil t nil nil))
  
  (use-local-map twelf-mode-map)
  
  (setq mode-name "Twelf"
	major-mode 'twelf-mode)
  (run-hooks 'twelf-mode-hook))

(provide 'twelf-mode)
