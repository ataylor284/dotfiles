;; don't wrap wide tabular output
(add-hook 'sql-interactive-mode-hook
          (lambda () (setq truncate-lines t)))
