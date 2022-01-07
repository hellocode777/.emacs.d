(setq byte-compile-warnings '(cl-function))
(require 'cl)

(when (>= emacs-major-version 24)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
)

(defvar zzss/packages '(
			use-package
			company evil
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
			;;bm
			rg
			helm-lsp
			project
			magit
			doom-modeline
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







;;;rg
(require 'rg)
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
  :dir project)


;;;evil-leader
(require 'evil-leader)
(global-evil-leader-mode)

(require 'use-package)
(require 'evil)
(evil-mode t)

;;;evil-escape
(require 'evil-escape)
(setq evil-escape-excluded-states '(normal visual multiedit emacs motion))
(setq evil-escape-excluded-major-modes '(neotree-mode treemacs-mode vterm-mode))
(setq evil-escape-key-sequence "jj")
(setq evil-escape-delay 0.25)
(evil-escape-mode)


;; company
;; http://company-mode.github.io/
(add-hook 'after-init-hook 'global-company-mode)


;;; hungry-delete
;;; delete many one time
(require 'hungry-delete)
(global-hungry-delete-mode)


;;; flycheck
(global-flycheck-mode)


;;; helm-mode
;;(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)


;;; ccls
(require 'ccls)
(setq ccls-executable "~/ccls/bin/ccls")


;;; lsp-mode
(lsp-mode t)
(lsp-treemacs-sync-mode 1)


;;; lsp-ui
(require 'lsp-ui)


;;; doom-modeline-mode
(doom-modeline-mode)




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
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;;;(setq xref-prompt-for-identifier nil)
(setq xref-prompt-for-identifier t)
(provide 'init-packages)
