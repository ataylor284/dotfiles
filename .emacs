;; paths n' stuff
(add-to-list 'load-path "~/elisp")
(setenv "PAGER" "cat")

;; global keyboard stuff
(global-set-key (kbd "C-\\") 'hippie-expand)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c l") 'linum-mode)

;; nice minimalist UI
(menu-bar-mode -1)
(cond (window-system
       (tool-bar-mode -1)
       (scroll-bar-mode -1)
       (set-foreground-color "green")
       (set-background-color "black")
       (set-default-font "Monospace 11")
       (setq x-select-enable-clipboard t)))

;; ansi color in shell mode and compilation buffers
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq x-stretch-cursor 't
      browse-url-browser-function 'browse-url-firefox
      browse-url-firefox-program "firefox-trunk"
      mouse-yank-at-point 't
      line-move-visual nil)

(set-default 'indent-line-function 'tab-to-tab-stop)

;; buffer naming
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; c family language stuff
(defun my-c-mode-hook ()
  (setq indent-tabs-mode nil
	c-basic-offset 4))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; groovy stuff
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(setq groovy-indent-level 4)
(setq groovy-indent-tabs-mode nil)
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))
(require 'find-dired)
(setq find-args "-name \*.groovy -o -name \*.java -o -name \*.gsp")
(push find-args find-args-history)

;; elisp stuff
(require 'cl)
(setq eval-expression-print-length nil)

;; twitter
(add-to-list 'load-path "~/elisp/twittering-mode")
(require 'twittering-mode)

;; erc IRC client stuff
(require 'erc-dcc)
(setq erc-fill-column 115)
(setq erc-pals '("bot"))
(setq erc-pal-highlight-type 'all)
(erc-spelling-mode 1)
(defun erc-global-notify (matched-type nick msg)
  (interactive)
  (when (eq matched-type 'current-nick)
    (let ((from-nick-short (car (split-string nick "!")))
	  (msg-flat (apply #'string (mapcar (lambda (c) (if (eq c ?\n) ?\s c)) msg))))
      (shell-command
       (concat "notify-send -t 4000 -c \"im.received\" \"" from-nick-short " mentioned your nick\" \"" msg-flat "\""))
      (let* ((tweet (concat from-nick-short ": " msg-flat))
	     (parameters `(("user" . "ataylor284")
			  ("text" . ,(substring tweet 0 (min (length tweet) 140))))))
	(twittering-http-post twittering-api-host
			      "1/direct_messages/new"
			      parameters)))))
(add-hook 'erc-text-matched-hook 'erc-global-notify)

;; SQL mode stuff
(add-hook 'sql-interactive-mode-hook
	  (lambda () (setq truncate-lines t)))

;; w3m
(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m")
(require 'w3m)
(add-hook 'w3m-mode-hook 
	  (lambda () (define-key w3m-mode-map (kbd "C-x b") nil))) ; really really really dislike w3m buffer switching override
(setq w3m-use-cookies t)
(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map "\C-xm" 'dired-w3m-find-file)))
(defun dired-w3m-find-file ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (y-or-n-p (format "Open 'w3m' %s " (file-name-nondirectory file)))
	(w3m-find-file file))))

;; misc packages
(when (require 'woman 'nil 't)
  (setq woman-use-own-frame nil
	woman-fill-column 75))

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

(defun default-windows ()
  "set up windows how i like em"
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (other-window 1)
  (switch-to-buffer "#VW")
  (other-window 1))
(global-set-key (kbd "C-c 1") 'default-windows)

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

