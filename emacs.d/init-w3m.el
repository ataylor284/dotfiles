(require 'w3m)
(add-hook 'w3m-mode-hook 
	    (lambda () (define-key w3m-mode-map (kbd "C-x b") nil))) ; really really really dislike w3m buffer switching override
(setq w3m-use-cookies t)
(add-hook 'dired-mode-hook
	    (lambda ()
	          (define-key dired-mode-map "\C-xm" 'dired-w3m-find-file)))
(defun dired-w3m-find-file ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (y-or-n-p (format "Open 'w3m' %s " (file-name-nondirectory file)))
	(w3m-find-file file))))
(defun w3m-this-file ()
  (interactive)
  (w3m-find-file (buffer-file-name)))
(global-set-key (kbd "C-c h") 'w3m-this-file)
(setq browse-url-browser-function 'w3m-browse-url)

