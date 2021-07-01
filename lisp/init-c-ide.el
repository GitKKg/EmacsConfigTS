
(require 'cflow-mode)
(defvar cmd nil nil)
(defvar cflow-buf nil nil)
(defvar cflow-buf-name nil nil)
(defvar trueFileName nil nil)

(defun yyc/cflow-function (function-name)
  "Get call graph of inputed function. "
  ;use gtags to get symbole in current point
  (interactive  (list (helm-gtags--read-tagname 'function-name) ))
  ;(interactive (list (car (senator-jump-interactive "Function name: " nil nil nil))))
  ;; tramp mode will get user@host... before path,so must cut off it.
  (if (file-remote-p (buffer-file-name))
      (setq trueFileName
            (nth 2 (split-string (buffer-file-name) "\:" ) )
            )
    setq trueFileName buffer-file-name)
  (setq cmd (format "cflow  -b --main=%s %s" function-name trueFileName))
  
  (setq cflow-buf-name (format "**cflow-%s:%s**"
                               (file-name-nondirectory trueFileName)
                               function-name))
  (setq cflow-buf (get-buffer-create cflow-buf-name))
  (set-buffer cflow-buf)
  (setq buffer-read-only nil)
  (erase-buffer)
  (insert (shell-command-to-string cmd))
  (pop-to-buffer cflow-buf)
  (goto-char (point-min))
  (cflow-mode)
  )

(defun yyc/cflow-function-reverse (function-name)
  "Get call graph of inputed function. "
  (interactive (list (helm-gtags--read-tagname 'function-name) ) )
  ;(interactive (list (car (senator-jump-interactive "Function name: " nil nil nil))))
  (if (file-remote-p (buffer-file-name))
      (setq trueFileName
            (nth 2 (split-string (buffer-file-name) "\:" ) )
            )
    setq trueFileName buffer-file-name
      )
  (setq cmd (format "cflow  -b -r --main=%s %s" function-name trueFileName))
  (setq cflow-buf-name (format "**cflow-%s:%s**"
                               (file-name-nondirectory trueFileName)
                               function-name))
  (setq cflow-buf (get-buffer-create (concat cflow-buf-name " reverse"))) ;; give a different name avoid buffer overwritten by direct or vice versa
  (set-buffer cflow-buf)
  (setq buffer-read-only nil)
  (erase-buffer)
  (insert (shell-command-to-string cmd))
  (pop-to-buffer cflow-buf)
  (goto-char (point-min))
  (cflow-mode)
  )

(provide 'init-c-ide)
