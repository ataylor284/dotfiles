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
(global-set-key (kbd "C-c q") 'bury-buffer)
(global-set-key (kbd "C-c o") 'ff-find-other-file)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-c i") 'string-inflection-toggle)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; nice minimalist UI
(menu-bar-mode -1)
(cond (window-system
       (tool-bar-mode -1)
       (scroll-bar-mode -1)
       (set-foreground-color "green")
       (set-background-color "black")
       (setq x-select-enable-clipboard t)
       (blink-cursor-mode -1)
       (setq visible-bell 1)))

;; windows/cygwin junk
(when (eq window-system 'w32)
;;  (require 'cygwin-mount)
;;  (cygwin-mount-activate)
  (setq w32-pass-lwindow-to-system nil
	w32-pass-rwindow-to-system nil
	w32-pass-apps-to-system nil
	w32-lwindow-modifier 'super
	w32-rwindow-modifier 'super
	w32-apps-modifier 'hyper
;;	cygwin-bin "c:/cygwin/bin"
;;	exec-path (cons cygwin-bin exec-path)
	find-program "/usr/bin/find.exe"
	shell-file-name "bash"
	explicit-shell-file-name "bash"
	jtags-etags-command "/usr/bin/find `pwd` -type f -name \*.java -exec cygpath -m {} + | etags --declarations --members -o %f -"))
;;  (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH"))))

;; OS X
(when (eq window-system 'ns)
  (setq exec-path (append exec-path '("/usr/local/bin" "/usr/X11/bin")))
  (set-default-font "Menlo-15")
  (setq save-interprogram-paste-before-kill nil
	mac-command-modifier 'meta))

;; ansi color in shell mode and compilation buffers
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq x-stretch-cursor 't
      mouse-yank-at-point 't
      line-move-visual nil)

(set-default 'indent-line-function 'tab-to-tab-stop)

;; buffer naming
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; c family language stuff
(defun my-c-mode-hook ()
  (setq indent-tabs-mode nil
        c-basic-offset 4
        show-trailing-whitespace t))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(load "~/.emacs.d/init-groovy")
(load "~/.emacs.d/init-elisp")
(load "~/.emacs.d/init-sql")
(load "~/.emacs.d/init-misc")
;;(load "~/.emacs.d/init-erc")
(if (or (> emacs-major-version 24)
	(and (= emacs-major-version 24) (>= emacs-minor-version 5)))
    (load "~/.emacs.d/init-eww")
  (load "~/.emacs.d/init-w3m"))
;;(load "~/.emacs.d/init-mozrepl")
(load "~/.emacs.d/init-scala")
(load "~/.emacs.d/string-inflection")
(load "~/.emacs.d/site-local.el" 'no-error)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(projectile-global-mode)
