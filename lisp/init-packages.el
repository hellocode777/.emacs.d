(setq byte-compile-warnings '(cl-function))
(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (package-initialize)
;;  (package-refresh-contents)
)

(defvar zzss/packages '(
			use-package
			company
			evil
			evil-escape
			evil-leader
			monokai-theme
			zenburn-theme
			helm-themes
			hungry-delete
			smex
			swiper
			counsel
			smartparens
			fzf
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
			bm
			rg
			helm-lsp
			project
			magit
                        shell-pop
                        treemacs
                        treemacs-evil
			treemacs-projectile
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


(global-company-mode)

(require 'evil-leader)
(global-evil-leader-mode)

(require 'use-package)
(require 'evil)
(evil-mode t)

(require 'hungry-delete)
(global-hungry-delete-mode)

(smartparens-global-mode t)

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;;(load-theme 'monokai t)
;;(load-theme 'zenburn t)
(require 'helm-config)
(require 'helm-themes)
;;;(helm-themes--load-theme "tango-dark")
;;(helm-themes--load-theme "manoj-dark")
(helm-themes--load-theme "monokai")

(global-flycheck-mode)

(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)



(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

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

(require 'evil-escape)
(setq evil-escape-excluded-states '(normal visual multiedit emacs motion))
(setq evil-escape-excluded-major-modes '(neotree-mode treemacs-mode vterm-mode))
(setq evil-escape-key-sequence "jj")
(setq evil-escape-delay 0.25)
(evil-escape-mode)



(require 'ccls)
(setq ccls-executable "~/ccls/bin/ccls")

;;;rg
(require 'rg)
(rg-enable-default-bindings)
(rg-define-search zs-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  :query point
  :format literal
  ;;;:files "all"
  :files "*.{c,cc,cpp,h,yang,esc,txt}"
  :dir project)

(rg-define-search zsr-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  :query point
  :format literal
  :files "all"
  :dir project)

(rg-define-search zss-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  :format literal
  ;;;:files "all"
  :files "*.{c,cc,cpp,h,yang,esc,txt}"
  :dir project)

(rg-define-search zssr-rg-dwim-project-dir
  "Search for thing at point in files matching the current file
under the project root directory."
  :format literal
  :files "all"
  :dir project)

(lsp-mode t)
(lsp-treemacs-sync-mode 1)


(setq xref-prompt-for-identifier nil)

;;;bm
(use-package bm
         :ensure t
         :demand t

         :init
         ;; restore on load (even before you require bm)
         (setq bm-restore-repository-on-load t)


         :config
         ;; Allow cross-buffer 'next'
         (setq bm-cycle-all-buffers t)

         ;; where to store persistant files
         (setq bm-repository-file "~/.emacs.d/bm-repository")

         ;; save bookmarks
         (setq-default bm-buffer-persistence t)

         ;; Loading the repository from file when on start up.
         (add-hook 'after-init-hook 'bm-repository-load)

         ;; Saving bookmarks
         (add-hook 'kill-buffer-hook #'bm-buffer-save)

         ;; Saving the repository to file when on exit.
         ;; kill-buffer-hook is not called when Emacs is killed, so we
         ;; must save all bookmarks first.
         (add-hook 'kill-emacs-hook #'(lambda nil
                                          (bm-buffer-save-all)
                                          (bm-repository-save)))

         ;; The `after-save-hook' is not necessary to use to achieve persistence,
         ;; but it makes the bookmark data in repository more in sync with the file
         ;; state.
         (add-hook 'after-save-hook #'bm-buffer-save)

         ;; Restoring bookmarks
         (add-hook 'find-file-hooks   #'bm-buffer-restore)
         (add-hook 'after-revert-hook #'bm-buffer-restore)

         ;; The `after-revert-hook' is not necessary to use to achieve persistence,
         ;; but it makes the bookmark data in repository more in sync with the file
         ;; state. This hook might cause trouble when using packages
         ;; that automatically reverts the buffer (like vc after a check-in).
         ;; This can easily be avoided if the package provides a hook that is
         ;; called before the buffer is reverted (like `vc-before-checkin-hook').
         ;; Then new bookmarks can be saved before the buffer is reverted.
         ;; Make sure bookmarks is saved before check-in (and revert-buffer)
         (add-hook 'vc-before-checkin-hook #'bm-buffer-save)


         :bind (("<f2>" . bm-next)
                ("S-<f2>" . bm-previous)
                ("C-<f2>" . bm-toggle))
         )

(require 'doom-modeline)
(doom-modeline-mode 1)

(provide 'init-packages)
