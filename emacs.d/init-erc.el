;; erc IRC client stuff
(require 'erc-dcc)
(setq erc-fill-column 115)
(setq erc-pals '("bot"))
(setq erc-pal-highlight-type 'all)
(erc-spelling-mode 1)
(defun erc-global-notify (matched-type nick msg)
  (interactive)
  (when (eq matched-type 'current-nick)
    (let ((from-nick-short (car (split-string nick "!")))
          (msg-flat (apply #'string (mapcar (lambda (c) (if (eq c ?\n) ?\s c)) msg))))
      (shell-command
       (concat "notify-send -t 4000 -c \"im.received\" \"" from-nick-short " mentioned your nick\" \"" msg-flat "\"")))))
(add-hook 'erc-text-matched-hook 'erc-global-notify)
