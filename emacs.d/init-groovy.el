;; groovy language
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)

(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))

(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(defun at/groovy-mode-hook ()
  (c-set-offset 'label 4))
(add-hook 'groovy-mode-hook 'at/groovy-mode-hook)
