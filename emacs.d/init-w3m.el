(require 'w3m)

(setq w3m-use-cookies t)

(defun at/w3m-hook ()
  "Really really really dislike w3m buffer switching override."
  (define-key w3m-mode-map (kbd "C-x b") nil))
(add-hook 'w3m-mode-hook 'at/w3m-hook)

(defun at/dired-w3m-find-file ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (y-or-n-p (format "Open 'w3m' %s " (file-name-nondirectory file)))
	(w3m-find-file file))))
(defun at/dired-browser-hook ()
  "Bind dired-w3m-find-file to key in dired."
  (define-key dired-mode-map "\C-xm" 'at/dired-w3m-find-file)))
(add-hook 'dired-mode-hook 'at/dired-browser-hook)

(defun at/browse-this-file ()
  (interactive)
  (w3m-find-file (buffer-file-name)))

(setq browse-url-browser-function 'w3m-browse-url)
