;; paths n' stuff
(add-to-list 'load-path "~/elisp")

;; global keyboard stuff
(global-set-key (kbd "C-\\") 'hippie-expand)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; nice minimalist UI
(cond (window-system
       (menu-bar-mode nil)
       (tool-bar-mode nil)
       (scroll-bar-mode nil)
       (set-foreground-color "green")
       (set-background-color "black")
       (set-default-font "Monospace 11")))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq x-stretch-cursor 't
      browse-url-browser-function 'browse-url-firefox
      mouse-yank-at-point 't)

(set-default 'indent-line-function 'tab-to-tab-stop)

;; c family language stuff
(defun my-c-mode-hook ()
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; groovy stuff
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(setq groovy-indent-level 8)
(setq groovy-indent-tabs-mode t)

;; erc IRC client stuff
(require 'erc-dcc)
(setq erc-fill-column 115)
(setq erc-pals '("bot"))
(setq erc-pal-highlight-type 'all)
(erc-spelling-mode 1)
(defun erc-global-notify (matched-type nick msg)
  (interactive)
  (when (eq matched-type 'current-nick)
    (shell-command
     (concat "notify-send -t 4000 -c \"im.received\" \""
             (car (split-string nick "!"))
             " mentioned your nick\" \""
             msg
             "\""))))
(add-hook 'erc-text-matched-hook 'erc-global-notify)

;; SQL mode stuff
(add-hook 'sql-interactive-mode-hook
	  (lambda () (setq truncate-lines t)))

;; misc packages
(require 'woman)
(setq woman-use-own-frame nil
      woman-fill-column 75)

;;(require 'twittering-mode)
(require 'hudson-watch)
;;(setq hudson-rss-url "")

(load-file "/home/ataylor/elisp/dvc/++build/dvc-load.el")

(server-start)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
