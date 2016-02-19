(defun at/scala-mode-hook ()
  (setq indent-tabs-mode nil
	show-trailing-whitespace t
	scala-indent:step 4))
(add-hook 'scala-mode-hook 'at/scala-mode-hook)
