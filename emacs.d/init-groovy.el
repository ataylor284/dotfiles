(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)

(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))

(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(setq groovy-indent-level 4)
(setq groovy-indent-tabs-mode nil)

(add-hook 'groovy-mode-hook
          (lambda ()
            (c-set-offset 'label 4)
            (setq show-trailing-whitespace t)))
