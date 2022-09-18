;;; init-packages.el --- Measure startup and require times -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq byte-compile-warnings '(cl-function))
(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)
)


(defvar zzss/packages '(
			use-package
			company
			evil
			evil-escape
			evil-leader
			hungry-delete
			smex
			swiper
			counsel
			smartparens
			ccls
			eglot
			lsp-mode
			lsp-ui
			flycheck
			yasnippet
			lsp-treemacs
			helm-lsp
			lsp-ivy
			hydra
			avy
			which-key
			helm-xref
			dap-mode
			rg
			helm-lsp
			project
			magit
			doom-modeline
			markdown-mode
			ace-jump-mode
			counsel-etags
			projectile
			sr-speedbar
			helm-themes
                       )"Default packages")

(setq package-selected-packages zzss/packages)
      
(defun zzss/packages-installed-p ()
  (loop for pkg in zzss/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (zzss/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg zzss/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))



(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))



;;;rg
(use-package rg
  :config
  (rg-enable-default-bindings)
  (rg-define-search zs-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  :query point
  :format regexp
  :flags ("--word-regexp")
  :menu ("Custom" "w" "Word")
  ;;:format literal
  ;;;:files "all"
  :files "*.{c,cc,cpp,h,yang,esc,txt}"
  :dir project)

(rg-define-search zsr-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  :query point
  :format regexp
  :flags ("--word-regexp")
  :menu ("Custom" "w" "Word")
  ;;;:format literal
  :files "all"
  :dir project)

(rg-define-search zss-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  ;;:format literal
  :format regexp
  ;;;:files "all"
  :flags ("--word-regexp")
  :menu ("Custom" "w" "Word")
  :files "*.{c,cc,cpp,h,yang,esc,txt}"
  :dir project)

(rg-define-search zssr-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  :format regexp
  :flags ("--word-regexp")
  :menu ("Custom" "w" "Word")
  ;;:format literal
  :files "all"
  :dir project)

(rg-define-search zss-rg-dwim-project-dir1
  "Search for thing at point in files matching the current file
under the project root directory."
  :format literal
  :files "*.{c,cc,cpp,h,yang,esc,txt}"
  :dir project))


;;;evil-leader
(use-package evil-leader
  :config
  (global-evil-leader-mode 1))


(use-package evil
  :config
  (evil-mode 1))

;;;evil-escape
(use-package evil-escape
  :config
  (setq evil-escape-excluded-states '(normal visual multiedit emacs motion))
  (setq evil-escape-excluded-major-modes '(neotree-mode treemacs-mode vterm-mode))
  (setq evil-escape-key-sequence "jj")
  (setq evil-escape-delay 0.25)
  (evil-escape-mode 1))


;; company
;; http://company-mode.github.io/
(add-hook 'after-init-hook 'global-company-mode)


;;; hungry-delete
;;; delete many one time
(use-package hungry-delete
  :config
  (global-hungry-delete-mode 1))


;;; flycheck
(global-flycheck-mode)


;;; helm-mode
;;(helm-mode)
(use-package helm-xref
  :config
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini))


;;; ccls
(use-package ccls
  :config
  (setq ccls-executable "~/ccls/bin/ccls"))


;;; lsp-mode
;;;(lsp-mode)
(lsp-treemacs-sync-mode 1)


;;; lsp-ui
(use-package lsp-ui)


;;; doom-modeline-mode
(doom-modeline-mode 1)
;;;(setq doom-modeline-buffer-file-name-style 'truncate-with-project)


;;(setq-local ff-ignore-include t)
;;(setq ff-ignore-include t)
(use-package find-file
  :config
  (setq cc-search-directories '("."
                              "../include" "../include/*" "../../include/*" "../../../include/*"
                              "../../include/*/*" "../../../include/*/*/*"
                              "../src" "../src/*" "../../src/*" "../../../src/*"
                              "../../src/*/*" "../../../src/*/*/*"
                              "/usr/include" "/usr/local/include/*")))


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(smartparens-global-mode)

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers 1)
  (setq enable-recursive-minibuffers t)
;;;(setq xref-prompt-for-identifier nil)
  (setq xref-prompt-for-identifier t))


;;; gdb
(setq gdb-show-main 1)

(use-package helm-themes
  :ensure t
  :config
  (load-theme 'light-blue t))

;;(semantic-mode t)
;;(semantic-stickyfunc-mode t)

(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

(provide 'init-packages)

;;; init-packages.el ends here
