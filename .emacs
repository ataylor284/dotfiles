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
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))

;; elisp stuff
(setq eval-expression-print-length nil)

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
(when (require 'woman 'nil 't)
  (setq woman-use-own-frame nil
	woman-fill-column 75))

;;(require 'twittering-mode)
(require 'hudson-watch)
;;(setq hudson-rss-url "")

(load-file "/home/ataylor/elisp/dvc/++build/dvc-load.el")

(server-start)

;; misc useful stuff
(defun recent-dired (dir prefix)
  "dired of files recently changed"
  (interactive "DRecently modified in directory: \np")
  (let ((do-it (lambda ()
		 (find-dired dir (format "-type f -mmin -%d" prefix))
		 (rename-buffer "*Recently Modified*" t)))
	(find-buffer (get-buffer "*Find*")))
    (if find-buffer
	(progn (set-buffer find-buffer)
	       (rename-buffer "*Find*temp" t)
	       (funcall do-it)
	       (set-buffer find-buffer)
	       (rename-buffer "*Find*"))
      (funcall do-it))))

(defun tab-width-toggle ()
  "toggle between 8 space and 4 space tabs"
  (interactive)
  (if (eq tab-width 4)
      (setq tab-width 8)
    (setq tab-width 4)
  (force-window-update (current-buffer))))
(global-set-key (kbd "C-c t") 'tab-width-toggle)

(defvar log-entry-regexp "^[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\},[0-9]\\{3\\} \\[.*?\\] "
  "A regexp that matches the beginning of a log entry from e.g. log4j")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; smex M-x replacement
(when (require 'smex 'nil 't)
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))


;; emms media player
(when (require 'emms 'nil 't)
  (require 'emms-player-mpd)
  (if (boundp 'emms-info-functions)
      (add-to-list 'emms-info-functions 'emms-info-mpd)
    (setq emms-info-functions '(emms-info-mpd))
  (add-to-list 'emms-player-list 'emms-player-mpd)))

