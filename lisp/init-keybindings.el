;;; init-keybindings.el --- Measure startup and require times -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
  (define-key evil-normal-state-map (kbd "z z") 'evil-write)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-line)
  (define-key evil-normal-state-map (kbd "H") 'evil-beginning-of-visual-line))

;;(projectile-mode +1)
;; Recommended keymap prefix on macOS
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
;;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(use-package evil-leader
  :config
  (evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "a" 'org-agenda
  "v" 'switch-to-buffer
  "b" 'buffer-menu
  "f" 'counsel-find-file
  "g" 'counsel-git
  "k" 'kill-buffer
  "s" 'swiper
  "m" 'magit-blame
  "w" 'evil-window-map
  "<" 'zss-rg-dwim-project-dir
  ">" 'zssr-rg-dwim-project-dir
  "/" 'zss-rg-dwim-project-dir1
  "*" 'zs-rg-dwim-project-dir
  "&" 'zsr-rg-dwim-project-dir
  "d" 'delete-window
  "r" 'lsp-ui-peek-find-references
  ;;"r" 'lsp-treemacs-references
  ;;"o" 'lsp-treemacs-symbols
  "o" 'treemacs-display-current-project-exclusively
  "c" 'with-editor-async-shell-command
  "e" 'ff-find-related-file
  "j" 'ace-jump-word-mode
  ))

(use-package projectile
  :config
  (evil-leader/set-key "p" 'projectile-command-map))

(use-package evil-org
  :config
  (evil-org-mode))

(add-hook 'org-mode-hook
 (lambda ()
   (evil-org-mode)

   ;; Custom mappings
   (evil-define-key 'normal evil-org-mode-map
     (kbd "-") 'org-ctrl-c-minus
     (kbd "|") 'org-table-goto-column
     (kbd "M-o") (evil-org-define-eol-command org-insert-heading)
     (kbd "M-t") (evil-org-define-eol-command org-insert-todo))

   ;; Configure leader key
   (evil-leader/set-key-for-mode 'org-mode
     "." 'hydra-org-state/body
     "t" 'org-todo
     "T" 'org-show-todo-tree
     "a" 'org-agenda
     "c" 'org-archive-subtree
     "l" 'evil-org-open-links
     "C" 'org-resolve-clocks)

   ;; Define a transient state for quick navigation
   (defhydra hydra-org-state ()
     ;; basic navigation
     ("i" org-cycle)
     ("I" org-shifttab)
     ("h" org-up-element)
     ("l" org-down-element)
     ("j" org-forward-element)
     ("k" org-backward-element)
     ;; navigating links
     ("n" org-next-link)
     ("p" org-previous-link)
     ("o" org-open-at-point)
     ;; navigation blocks
     ("N" org-next-block)
     ("P" org-previous-block)
     ;; updates
     ("." org-ctrl-c-ctrl-c)
     ("*" org-ctrl-c-star)
     ("-" org-ctrl-c-minus)
     ;; change todo state
     ("H" org-shiftleft)
     ("L" org-shiftright)
     ("J" org-shiftdown)
     ("K" org-shiftup)
     ("t" org-todo))))

(provide 'init-keybindings)

;;; init-keybindings.el ends here
