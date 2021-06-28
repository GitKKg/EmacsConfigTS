;; init-remote.el --- Initialize remote working configurations.	-*- lexical-binding: t -*-
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;             Remote working by tramp,eshell etc, configurations
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:
;;qw1 added for tramp password saving in current session only
;;(setq password-cache-expiry nil)
;;(require 'recentf)
;;(recentf-mode 1)
;;(require 'init-PureScript)
(setq password-cache-expiry nil)

;; for issue shell in tramp is slow
(setq projectile-mode-line "Projectile")
(setq remote-file-name-inhibit-cache t) ;; nil is quciker,but less safe
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 1)

;;qw1, workspace for multiple projects buffers switch
;; this way of installing package need download relevant el files and put them in .emacs.d,not updating in time
;;(require 'perspective)
;; if not foud on melpha for emacs 26.3,pls M-x refresh package contents
(use-package perspective
  :bind (
         ("C-x b" . persp-switch-to-buffer*)
         ("C-x k" . persp-kill-buffer*)
         ;;("C-x C-b" . persp-list-buffers)
         ("C-x C-b" . persp-ibuffer)
         )
  :config
  (persp-mode))
;;(setq persp-mode t)
(setq persp-state-default-file "~/perspectiveWorkSpace")

;;Just asking password when boot emacs,even get authinfo.gpg,and consider effect loading speed every time,so just diable auto save and load
;;(persp-state-load persp-state-default-file)
;;(add-hook 'kill-emacs-hook #'persp-state-save)
;; above position is just senstive,if place above tramp-verbose 1 or projectile,emacs will freeze here,if place at the end of init.el,persp-state-load just actually not work and without any error warning notice inform

;;just diable company-mode when remote shell in Tramp
(defun my-shell-mode-setup-function ()
  (when (and (fboundp 'company-mode)
             (file-remote-p default-directory))
    (company-mode -1)))
(add-hook 'shell-mode-hook 'my-shell-mode-setup-function)

;; for eshell auto complete
(setq eshell-cmpl-cycle-completions nil)

;;david, let tramp use .ssh config
;;(setq tramp-use-ssh-controlmaster-options nil)
;;(customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
;;(setq tramp-ssh-controlmaster-options "-o ControlMaster=yes -o ControlPersist=yes")


;;qw1
;; make the other window is default target for copy paste of dired
(setq dired-dwim-target t)

;; for github token store
(setq auth-sources '("~/.authinfo.gpg"))

(provide 'init-remote)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-remote.el ends here
