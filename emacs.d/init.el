;; paths n' stuff
(add-to-list 'load-path "~/elisp")
(setenv "PAGER" "cat")
(prefer-coding-system 'utf-8-unix)

;; nice minimalist UI
(menu-bar-mode -1)
(setq x-stretch-cursor 't
      mouse-yank-at-point 't
      line-move-visual nil)

(cond (window-system
       (load "~/.emacs.d/window-system-all")
       (load (format "~/.emacs.d/window-system-%s" window-system) 'no-error)))

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(defvar at/packages '(autodisass-java-bytecode browse-kill-ring coffee-mode
					       dockerfile-mode groovy-mode
					       markdown-mode projectile
					       scala-mode2 twittering-mode
					       ws-butler))
(dolist (p at/packages)
  (when (not (package-installed-p p))
    (package-install p)))

(projectile-global-mode)
(require 'autodisass-java-bytecode)

(load "~/.emacs.d/init-programming-modes")
(load "~/.emacs.d/init-misc")
;;(load "~/.emacs.d/init-erc")
(if (or (> emacs-major-version 24)
	(and (= emacs-major-version 24) (>= emacs-minor-version 5)))
    (load "~/.emacs.d/init-eww")
  (load "~/.emacs.d/init-w3m"))
;;(load "~/.emacs.d/init-mozrepl")
(load "~/.emacs.d/string-inflection")
(load "~/.emacs.d/site-local.el" 'no-error)

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
(global-set-key (kbd "C-c t") 'at/tab-width-toggle)
(global-set-key (kbd "C-c 1") 'at/default-windows)
(global-set-key (kbd "C-c h") 'at/browse-this-file)
(global-set-key (kbd "<f9>") 'recompile)
(global-set-key (kbd "C-=") 'at/inline-calc)

;; stuff to put in the global namespace
(defalias 'tab-width-toggle 'at/tab-width-toggle)
(defalias 'recent-dired 'at/recent-dired)
(defalias 'make-invoice 'at/make-invoice)
(defalias 'make-java-accessors 'at/make-java-accessors)
(defalias 'comint-clear 'at/comint-clear)
