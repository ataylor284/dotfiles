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
(setq x-stretch-cursor 't
      mouse-yank-at-point 't
      line-move-visual nil)

(cond (window-system
       (load "~/.emacs.d/window-system-all")
       (load (format "~/.emacs.d/window-system-%s" window-system) 'no-error)))

;; c family language stuff
(defun my-c-mode-hook ()
  (setq indent-tabs-mode nil
        c-basic-offset 4
        show-trailing-whitespace t))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

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

(projectile-global-mode)
