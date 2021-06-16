;;; init.el --- user init configuration.	-*- lexical-binding: t no-byte-compile: t; -*-
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (version< emacs-version "24.4")
  (error "This requires Emacs 24.4 and above!"))

;; Accept safe local variables
(setq enable-local-variables :safe)

;; Optimize loading performance
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after init"
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold 800000)))

;; Prefers the newest version of a file
(setq load-prefer-newer t)

;; Load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp/org-mode/lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp/org-mode/contrib/lisp" user-emacs-directory) t)

;; Constants
(require 'init-const)

;; Customization
(require 'init-custom)

;; Packages
(require 'init-package)

;; Basic packages and settings
(require 'init-basic)
(require 'init-utils)

(require 'init-ui)
(require 'init-theme)
(require 'init-edit)
(require 'init-ibuffer)
(require 'init-highlight)
(require 'init-window)
;; (require 'init-ivy)
(require 'init-helm)
(require 'init-flycheck)
(require 'init-projectile)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-python)
;; (require 'init-scala)
(require 'init-vcs)
(require 'init-org)
(require 'init-restclient)
(require 'init-plantuml)
(require 'init-graphviz)
(require 'init-haskell)
(require 'init-clike)
(require 'init-web)
(require 'init-elm)
(require 'init-yaml)



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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
