;; everything
(setq at/max-line-width 120)
(setq-default indent-tabs-mode nil)
(setq-default fci-rule-column at/max-line-width)

(defun at/highlight-fixmes ()
  (font-lock-add-keywords nil
                          '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t))))
(add-hook 'prog-mode-hook 'at/highlight-fixmes)

;; elisp
; load common lisp aliases
(require 'cl)
; don't tuncate expressions in repl
(setq eval-expression-print-length nil)

;; c family language stuff
(defun at/c-mode-hook ()
  (setq indent-tabs-mode nil
        c-basic-offset 4
        show-trailing-whitespace t
        fill-column at/max-line-width)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0))

(add-hook 'c-mode-common-hook 'at/c-mode-hook)

;; groovy
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)

(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))

(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(defun at/groovy-mode-hook ()
  (c-set-offset 'label 4)
  (setq indent-tabs-mode nil
        show-trailing-whitespace t
        fill-column at/max-line-width))
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

;; test counterpart files for java, groovy, etc.
(defun at/find-file-test-counterpart ()
  (interactive)
  (let* ((filename (buffer-file-name))
         (is-test-file (string-match "Test\\." filename))
         (counterpart
          (or
           (and (boundp 'counterpart) counterpart) ; counterpart local variable, if set
           (if is-test-file                        ; otherwise mangle name
               (replace-regexp-in-string "/test/" "/main/" (replace-regexp-in-string "Test\\(\\.[a-z]+\\)" "\\1" filename))
             (replace-regexp-in-string "/main/" "/test/" (replace-regexp-in-string "\\(\\.[a-z]+\\)" "Test\\1" filename))))))
    (find-file counterpart)))
