(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(add-hook 'js-mode-hook 'javascript-custom-setup)
(defun javascript-custom-setup ()
  (moz-minor-mode 1))
(defun moz-reload ()
  "Reload firefox with mozrepl."
  (interactive)
  (comint-send-string (inferior-moz-process) "BrowserReload();"))
(global-set-key (kbd "C-c r") 'moz-reload)
