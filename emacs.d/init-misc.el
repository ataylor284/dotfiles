;; general enhancments
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(require 'ffap) ; find-file-at-point
(ffap-bindings)

;; buffer naming
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; backups
(setq version-control t
      delete-old-versions t
      kept-old-versions 3
      kept-new-versions 3)

;; ansi color in shell mode and compilation buffers
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun at/colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'at/colorize-compilation-buffer)

;; tab stuff
(set-default 'indent-line-function 'tab-to-tab-stop)
(setq tab-width 4)
(defun at/tab-width-toggle ()
  "Toggle between 8 space and 4 space tabs."
  (interactive)
  (if (eq tab-width 4)
      (setq tab-width 8)
    (setq tab-width 4))
  (force-window-update (current-buffer)))

;; tramp stuff
(setq password-cache-expiry (* 60 30))

;; load find-dired and push a useful default into the history
(require 'find-dired)
(setq interesting-file-extensions '("java" "groovy" "js" "jsp" "gsp" "xml" "properties"))
(setq find-args (concat "-path ./build -prune -o "
                        (mapconcat (apply-partially 'format "-name \\*.%s") interesting-file-extensions " -o ")))
(push find-args find-args-history)

;; twittering
(setq twittering-fill-column 80
      twittering-use-native-retweet t
      twittering-username-face '((t (:foreground "orange" :underline t))))

;; quick access to preferred window layout
(defun at/default-windows ()
  "set up windows how i like em"
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (other-window 1)
  (switch-to-buffer "*shell*")
  (other-window 1))

(defun at/recent-dired (dir prefix)
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
(defun at/make-invoice (rate hours)
  (interactive "nRate: \nnHours: ")
  (pop-to-buffer (generate-new-buffer "*Invoice*"))
  (insert "Invoice\n\n")
  (insert (format "%.2f hours @ $%.2f/hr\t$%.2f\n" hours rate (* hours rate)))
  (insert (format "GST\t\t\t\t\$%.2f\n" (* 0.05 hours rate)))
  (insert (format "Total\t\t\t\t\$%.2f\n" (* 1.05 hours rate))))

;; quick java getter and setter shortcut
(defun at/make-java-accessors (name type)
  "Insert Java getter and setter at the point for a given name and type."
  (interactive "sName: \nsType: ")
  (let ((capname (string-inflection-camelcase-function name)))
    (insert (format "public %s get%s() {\n" type capname))
    (insert (format "        return %s;\n" name))
    (insert "    }\n\n")
    (insert (format "    public void set%s(%s %s) {\n" capname type name))
    (insert (format "        this.%s = %s;\n" name name))
    (insert "    }\n\n")))

(defun at/comint-clear ()
  "Truncate the buffer and clear the screen in a comint buffer."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun at/inline-calc (arg)
  "Evaluate a region as an algebraic expression via Calc.  Either
replace it with or append to it (if given a prefix argument) the
result."
  (interactive "P")
  (require 'calc)
  (let ((calc-multiplication-has-precedence nil)
	(result (calc-eval (buffer-substring (region-beginning) (region-end)))))
    (if (not arg)
	(delete-region (region-beginning) (region-end))
      (goto-char (region-end))
      (insert " = "))
    (insert result)))

(defun at/restclient ()
  (interactive)
  (require 'restclient)
  (pop-to-buffer (generate-new-buffer "*rest*"))
  (insert "GET http://127.0.0.1:8081/")
  (restclient-mode))

;; test counterpart files for java, groovy, etc.
(defun at/find-file-test-counterpart ()
  (interactive)
  (let* ((filename (buffer-file-name))
         (is-test-file (string-match "Test\\." filename))
         (counterpart (if is-test-file
                          (replace-regexp-in-string "/test/" "/main/" (replace-regexp-in-string "Test\\(\\.[a-z]+\\)" "\\1" filename))
                        (replace-regexp-in-string "/main/" "/test/" (replace-regexp-in-string "\\(\\.[a-z]+\\)" "Test\\1" filename)))))
    (find-file counterpart)))

