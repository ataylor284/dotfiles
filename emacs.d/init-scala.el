(add-hook 'scala-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil
                  show-trailing-whitespace t
                  scala-indent:step 4)))
