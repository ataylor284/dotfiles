(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "\C-xm" 'dired-eww-find-file)))
(defun dired-eww-find-file ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (y-or-n-p (format "Open 'eww' %s " (file-name-nondirectory file)))
        (eww-open-file file))))
