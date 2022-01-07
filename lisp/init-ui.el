(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq inhibit-splash-screen t)

(setq-default cursor-type 'bar)

(setq initial-frame-alist (quote ((fullscreen . maximized))))

(global-linum-mode t)
;;(global-linum-mode nil)

;;;以y/n代表yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(setq frame-title-format
'("%s" (buffer-file-name "%f"
        (dired-directory dired-directory "%b"))))


;;;防止页面滚动时跳动
(setq scroll-margin 3
scroll-conservatively 10000)

;;;在状态条上显示当前光标在哪个函数体内部
(which-function-mode t)



(defun gromacs-c-mode-common-hook ()
;; GROMACS customizations for c-mode

(c-set-offset 'substatement-open 0)
(c-set-offset 'innamespace 0)
;; other customizations can go here

(setq c++-tab-always-indent t)
(setq c-basic-offset 4)                  ;; Default is 2
(setq c-indent-level 4)                  ;; Default is 2
(setq c-file-style "stroustrup")
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
(setq tab-width 4)
(setq indent-tabs-mode nil)  ; use tabs if t
)
(add-hook 'c-mode-common-hook 'gromacs-c-mode-common-hook)

(defun gromacs-c++-mode-common-hook ()
;; GROMACS customizations for c++-moe

(c++-set-offset 'substatement-open 0)
(c++-set-offset 'innamespace 0)
;; other customizations can go here

(setq c++-tab-always-indent t)
(setq c++-basic-offset 4)                  ;; Default is 2
(setq c++-indent-level 4)                  ;; Default is 2
(setq c++-file-style "stroustrup")

(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
(setq tab-width 4)
(setq indent-tabs-mode nil)  ; use tabs if t
)

(add-hook 'c++-mode-common-hook 'gromacs-c++-mode-common-hook)



(provide 'init-ui)

;;; init-ui.el ends here
