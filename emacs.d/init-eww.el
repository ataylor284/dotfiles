(defun at/dired-eww-find-file ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (y-or-n-p (format "Open 'eww' %s " (file-name-nondirectory file)))
        (eww-open-file file))))
(defun at/dired-browser-hook ()
  "Bind dired-eww-find-file to key in dired."
  (define-key dired-mode-map "\C-xm" 'at/dired-eww-find-file))
(add-hook 'dired-mode-hook 'at/dired-browser-hook)

(defun at/browse-this-file ()
  (interactive)
  (eww-open-file (buffer-file-name)))
