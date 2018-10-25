;; OS X
(setq exec-path (append exec-path '("/usr/local/bin" "/usr/X11/bin")))

(add-to-list 'default-frame-alist '(font . "Menlo-15"))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(setq save-interprogram-paste-before-kill nil
      mac-command-modifier 'meta)
