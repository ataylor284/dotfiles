;; GUI mode UI settings
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(setq x-select-enable-clipboard t
      visible-bell 1)

(add-to-list 'default-frame-alist '(foreground-color . "green"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(cursor-color . "white"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
