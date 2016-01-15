
;; tab width stuff
(setq tab-width 4)
(defun tab-width-toggle ()
  "toggle between 8 space and 4 space tabs"
  (interactive)
  (if (eq tab-width 4)
      (setq tab-width 8)
    (setq tab-width 4)
  (force-window-update (current-buffer))))
(global-set-key (kbd "C-c t") 'tab-width-toggle)

;; load find-dired and push a useful default into the history
(require 'find-dired)
(setq interesting-file-extensions '("java" "groovy" "js" "jsp" "gsp" "xml" "properties"))
(setq find-args (concat "-path ./build -prune -o "
                        (mapconcat (apply-partially 'format "-name \\*.%s") interesting-file-extensions " -o ")))
(push find-args find-args-history)

;; quick access to preferred window layout
(defun default-windows ()
  "set up windows how i like em"
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (other-window 1)
  (switch-to-buffer "*shell*")
  (other-window 1))
(global-set-key (kbd "C-c 1") 'default-windows)

(defun recent-dired (dir prefix)
  "dired of files recently changed"
  (interactive "DRecently modified in directory: \np")
  (let ((do-it (lambda ()
                 (find-dired dir (format "-type f -mmin -%d" prefix))
                 (rename-buffer "*Recently Modified*" t)))
        (find-buffer (get-buffer "*Find*")))
    (if find-buffer
        (progn (set-buffer find-buffer)
               (rename-buffer "*Find*temp" t)
               (funcall do-it)
               (set-buffer find-buffer)
               (rename-buffer "*Find*"))
      (funcall do-it))))

;; whip up a quick invoice
(defun make-invoice (rate hours)
  (interactive "nRate: \nnHours: ")
  (pop-to-buffer (generate-new-buffer "*Invoice*"))
  (insert "Invoice\n\n")
  (insert (format "%.2f hours @ $%.2f/hr\t$%.2f\n" hours rate (* hours rate)))
  (insert (format "GST\t\t\t\t\$%.2f\n" (* 0.05 hours rate)))
  (insert (format "Total\t\t\t\t\$%.2f\n" (* 1.05 hours rate))))

;; quick java getter and setter shortcut
(defun make-java-accessors (name type)
  "Insert Java getter and setter at the point for a given name and type."
  (interactive "sName: \nsType: ")
  (let ((capname (string-inflection-camelcase-function name)))
    (insert (format "public %s get%s() {\n" type capname))
    (insert (format "        return %s;\n" name))
    (insert "    }\n\n")
    (insert (format "    public void set%s(%s %s) {\n" capname type name))
    (insert (format "        this.%s = %s;\n" name name))
    (insert "    }\n\n")))

(defun comint-clear ()
  "Truncate the buffer and clear the screen in a comint buffer."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
