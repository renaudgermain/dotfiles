(define-key global-map "\M-g"     'goto-line)
(define-key global-map "\C-cr"    'replace-string)
(define-key global-map "\C-cs"    'linum-mode)
(define-key global-map "\C-x\C-f" 'find-file-at-point)

(defun roll (x) (+ (random x) 1))

;; adwaita and wheatgrass look tolerable so far
;; (load-theme 'adwaita)
;; M-x list-color-display
;; /usr/share/emacs/24.5/etc/themes/
;; installed rxvt-unicode-256color
(add-to-list 'custom-theme-load-path "~/.emacs.d/cyberpunk-theme.el"); from https://emacsthemes.com -> https://github.com/n3mo/cyberpunk-theme.el
(add-hook 'after-init-hook (lambda () (load-theme 'cyberpunk t)))
;; annoying: have to set TERM=xterm-256color until I get the other defined
;; colors not in sync w/ LS_COLORS & mutt

(setq default-tab-width              3
      scroll-step                    1
      inhibit-startup-message        t
      require-final-newline          t
      next-line-add-newlines         nil
      scheme-program-name            "mzscheme -m"
      shell-command-switch           "-fc"
      default-enable-multibyte-characters t
      cssm-indent-function           #'cssm-c-style-indenter
      default-input-method           "TeX" ;; write non-ascii characters as TeX expressions
      linum-format                   "%3d "
      ispell-program-name            "aspell"
      visible-cursor                 nil
      js-indent-level                2
      ido-ignore-buffers             '("\\` " "^\*"))

(setq-default transient-mark-mode    t
              truncate-lines         t
              indent-tabs-mode       nil
              fill-column            80
              mode-line-format       nil)

(load "~/.emacs.d/beluga-mode.el")
(load "~/.emacs.d/fish-mode.el")
(load "~/.emacs.d/go-mode.el")

(menu-bar-mode -1)
(show-paren-mode t)
(global-font-lock-mode t)
(ido-mode t)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;; more utf-8, does it help?
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; Install MELPA eventually:  http://ergoemacs.org/emacs/emacs_package_system.html

(setq fish-mode-hook       '((lambda () (linum-mode 1)))
      emacs-lisp-mode-hook '((lambda () (linum-mode 1)))
      javascript-mode      '((lambda () (linum-mode 1)))
      haskell-mode-hook    '((lambda () (linum-mode 1)))
      html-mode-hook       '((lambda () (linum-mode 1)))
      css-mode-hook        '((lambda () (linum-mode 1)))
      go-mode-hook        '((lambda () (linum-mode 1)))
      mail-mode-hook       '(auto-fill-mode)
      ;; haskell-mode-hook '((lambda () (load "haskell-site-file.el")))
      ;; sml-mode-hook    '(lambda () (defun run-sml () (interactive) (sml-run "sml" "-Cprint.depth=100")))
      )
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'tuareg-mode-hook 'toggle-input-method)

(setq auto-mode-alist
      (append '(
                ("\\.oct$"            . octave-mode)
                ("\\.latex$"          . latex-mode)
                ("Muttrc"             . muttrc-mode)
                ("^\/tmp\/mutt"       . mail-mode)
                ("^\/etc\/"           . shell-script-mode)
                ("\\.py$"             . python-mode)
                ("\\.pum$"            . c-mode)
                ("\\.prs$"            . c-mode)
                ("\\.cg$"             . c-mode)
                ("\\.php$"            . html-mode)
                )
              auto-mode-alist
              '(
                ("^\/home\/rcog\/\\."        . shell-script-mode)
                )
              ))

;; org-mode
(setq org-todo-keywords
      '((sequence "TODO" "NEXT" "WAIT" "|" "DONE")))

(setq org-todo-keyword-faces
;;; '(("TODO" . org-warning)   ; (:foreground "red"    :weight bold))
      '(("TODO" . (:foreground "red"    :weight bold))
;;;        ("NEXT" . (:foreground "yellow" :weight bold))
;;;        ("WAIT" . (:foreground "yellow" :weight bold))
;;;        ("DONE" . (:foreground "blue"   :weight normal))))
        ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0eb173dcdd23dbc02e0a178c7e8d3d9a9697786c11ef68b77b8b6255d4163cfd" default)))
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cyberpunk-transparent-background t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
