;; init-PureScript.el --- Initialize purescript configurations.	-*- lexical-binding: t -*-
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;             PureScript configurations.
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

;; Kant added,Syntax Highlighting and indentation (adapted from haskell-mode)
;; use-package will auto download packge from MELPA if it's not installed
;; just like M-x package-install
(use-package purescript-mode)

(use-package psci
  ;;:init
  ;;(add-hook 'purescript-mode-hook 'inferior-psci-mode)
  )

;;exposing the compilers IDE support
(use-package psc-ide
  :init
  (add-hook 'purescript-mode-hook
           (lambda ()
             (psc-ide-mode)
             (company-mode)
             (flycheck-mode)
             (turn-on-purescript-indentation))))

(provide 'init-PureScript)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-PureScript.el ends here
