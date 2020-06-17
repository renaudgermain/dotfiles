(define-key global-map "\C-x\C-f" 'find-file-at-point)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
;; M-x package-refresh-contents
;; M-x package-install RET markdown-mode RET

(add-to-list 'custom-theme-load-path "~/.emacs.d/cyberpunk-theme.el"); from https://emacsthemes.com -> https://github.com/n3mo/cyberpunk-theme.el
(add-hook 'after-init-hook (lambda () (load-theme 'cyberpunk t)))

(transient-mark-mode 1)
(menu-bar-mode -1)
(show-paren-mode t)
(save-place-mode 1)
(ido-mode t)

(setq default-tab-width              2
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
      browse-url-browser-function    'browse-url-generic
      browse-url-generic-program     "x-www-browser"
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

(setq fish-mode-hook       '((lambda () (linum-mode 1)))
      emacs-lisp-mode-hook '((lambda () (linum-mode 1)))
      js-mode-hook         '((lambda () (linum-mode 1)))
      haskell-mode-hook    '((lambda () (linum-mode 1)))
      html-mode-hook       '((lambda () (linum-mode 1)))
      html-mode-hook       '((lambda ()
                               (linum-mode 1)
                               (set (make-local-variable 'sgml-basic-offset) 4)))
      nxml-mode-hook       '((lambda () (linum-mode 1)))
      java-mode-hook       '((lambda () (linum-mode 1)
                               (setq indent-tabs-mode t)
                               (setq c-offsets-alist
                                     (append '((arglist-intro . +) (case-label . +))
                                             c-offsets-alist))
                               (setq c-basic-offset 2)))
      css-mode-hook        '((lambda () (linum-mode 1)))
      go-mode-hook         '((lambda () (linum-mode 1)))
      mail-mode-hook       '(auto-fill-mode)
      ;; haskell-mode-hook '((lambda () (load "haskell-site-file.el")))
      ;; sml-mode-hook    '(lambda () (defun run-sml () (interactive) (sml-run "sml" "-Cprint.depth=100")))
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
                )
              auto-mode-alist
              (list (cons (concat "^" (expand-file-name "~/") "\\.") 'shell-script-mode))
              ))

(add-hook 'before-save-hook 'delete-trailing-whitespace);; TODO indent file, update copyright, remove unused imports, TODO disable when editing liquidbase changesets (e.g. update_MAIN.xml)

;; TODO java format on save

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0eb173dcdd23dbc02e0a178c7e8d3d9a9697786c11ef68b77b8b6255d4163cfd" default)))
 '(cyberpunk-transparent-background t)
 '(package-selected-packages
   (quote
    (scala-mode fish-mode markdown-mode haskell-mode go-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))
