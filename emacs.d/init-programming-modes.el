;; elisp
; load common lisp aliases
(require 'cl)
; don't tuncate expressions in repl
(setq eval-expression-print-length nil)

;; c family language stuff
(defun at/c-mode-hook ()
  (setq indent-tabs-mode nil
        c-basic-offset 4
        show-trailing-whitespace t))
(add-hook 'c-mode-common-hook 'at/c-mode-hook)

;; groovy
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)

(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))

(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(defun at/groovy-mode-hook ()
  (c-set-offset 'label 4))
(add-hook 'groovy-mode-hook 'at/groovy-mode-hook)

;; scala
(defun at/scala-mode-hook ()
  (setq indent-tabs-mode nil
	show-trailing-whitespace t
	scala-indent:step 4))
(add-hook 'scala-mode-hook 'at/scala-mode-hook)

;; javascript
(defun at/js-mode-hook ()
  (setq indent-tabs-mode nil
	js-indent-level 2))
(add-hook 'js-mode-hook 'at/js-mode-hook)
(setenv "NODE_NO_READLINE" "1")
