;; windows/cygwin junk

;(require 'cygwin-mount)
;(cygwin-mount-activate)
(setq w32-pass-lwindow-to-system nil
      w32-pass-rwindow-to-system nil
      w32-pass-apps-to-system nil
      w32-lwindow-modifier 'super
      w32-rwindow-modifier 'super
      w32-apps-modifier 'hyper
;     cygwin-bin "c:/cygwin/bin"
;     exec-path (cons cygwin-bin exec-path)
      find-program "/usr/bin/find.exe"
      shell-file-name "bash"
      explicit-shell-file-name "bash"
      jtags-etags-command "/usr/bin/find `pwd` -type f -name \*.java -exec cygpath -m {} + | etags --declarations --members -o %f -")
;(setenv "PATH" (concat cygwin-bin ";" (getenv "PATH"))))
