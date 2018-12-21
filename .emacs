(define-key global-map "\C-x\C-f" 'find-file-at-point)
(global-set-key (kbd "M-RET") 'java-imports-add-import-dwim)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
;; M-x package-install RET markdown-mode RET

(transient-mark-mode 1)
(menu-bar-mode -1)
(show-paren-mode t)
(save-place-mode 1)
(ido-mode t)
(jdecomp-mode 1)

(setq default-tab-width              2
      sh-basic-offset                2
      scroll-step                    1
      inhibit-startup-message        t
      require-final-newline          t
      next-line-add-newlines         nil
      shell-command-switch           "-fc"
      default-enable-multibyte-characters t
      cssm-indent-function           #'cssm-c-style-indenter
      default-input-method           "TeX" ;; write non-ascii characters as TeX expressions
      linum-format                   "%3d "
      ispell-program-name            "aspell"
      visible-cursor                 nil
      js-indent-level                2
      browse-url-browser-function    'browse-url-firefox
      ido-ignore-buffers             '("\\` " "^\*" "TAGS")
      org-startup-folded             'content
      tags-case-fold-search          nil
      org-todo-keywords              '((sequence "TODO" "NEXT" "WAIT" "|" "DONE"))
      org-todo-keyword-faces         '(("TODO" . (:foreground "red"    :weight bold))
                                       ("WAIT" . (:foreground "orange" :weight bold)))
      )

(setq-default transient-mark-mode    t
              indent-tabs-mode       nil
              truncate-lines         t
              fill-column            80
              mode-line-format       nil)

;; https://emacs.stackexchange.com/questions/17440/define-the-behaviour-of-help-window
(setq fish-mode-hook       '((lambda () (linum-mode 1)))
      emacs-lisp-mode-hook '((lambda () (linum-mode 1)))
      javascript-mode      '((lambda () (linum-mode 1)))
      haskell-mode-hook    '((lambda () (linum-mode 1)))
      html-mode-hook       '((lambda ()
                               (linum-mode 1)
                               (set (make-local-variable 'sgml-basic-offset) 4)))
      nxml-mode-hook       '((lambda () (linum-mode 1)))
      java-mode-hook       '((lambda () (linum-mode 1)
                               (setq indent-tabs-mode t)
                               (lambda () (java-imports-scan-file))
                               (setq c-offsets-alist
                                     (append '((arglist-intro . +) (case-label . +) (arglist-cont-nonempty . +) (arglist-close . 0))
                                             c-offsets-alist))
                               (setq c-basic-offset 2)))
      css-mode-hook        '((lambda () (linum-mode 1)))
      go-mode-hook         '((lambda () (linum-mode 1)))
      mail-mode-hook       '(auto-fill-mode)
      python-mode-hook     '((lambda () (linum-mode 1)))
      scala-mode-hook      '((lambda () (linum-mode 1)))
      ;; haskell-mode-hook '((lambda () (load "haskell-site-file.el")))
      ;; sml-mode-hook    '(lambda () (defun run-sml () (interactive) (sml-run "sml" "-Cprint.depth=100")))
      before-save-hook     '(delete-trailing-whitespace (lambda () (copyright-update t)));; TODO indent file, remove unused imports, TODO disable when editing liquidbase changesets (e.g. update_MAIN.xml)
      )
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'tuareg-mode-hook 'toggle-input-method)

(setq auto-mode-alist
      (append '(
                ("\\.latex$"          . latex-mode)
                ("Muttrc"             . muttrc-mode)
                ("^\/tmp\/mutt"       . mail-mode)
                ("^\/etc\/"           . shell-script-mode)
                ("\\.py$"             . python-mode)
                ("\\.php$"            . html-mode)
                ("\\.org$"            . org-mode)
                ("\\.sql\\.ftl$"      . sql-mode)
                ("\\.mustache"        . mustache-mode)
                )
              auto-mode-alist
              (list (cons (concat "^" (expand-file-name "~/") "\\.") 'shell-script-mode))
              ))

;; TODO java format on save

(customize-set-variable
 'display-buffer-alist
 '(
   ;; ("\\*xref\\*" display-buffer-below-selected); switch-to-buffer might be sensible
   ;; ("\\*Help\\*" display-below-selected)
   )); display temporary *Help* buffer at the bottom, see https://www.gnu.org/software/emacs/manual/html_node/elisp/Display-Action-Functions.html
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (apples-mode mustache mustache-mode dockerfile-mode java-imports yaml-mode scala-mode feature-mode markdown-mode jdecomp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(customize-set-variable 'jdecomp-decompiler-paths '((cfr . "/usr/local/Cellar/cfr-decompiler/0.128/libexec/cfr_0_128.jar")))
(customize-set-variable 'copyright-regexp "\\(Copyright\\s *\\)\\(2[0-9]+\\)")
(customize-set-variable 'copyright-query nil)

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))
