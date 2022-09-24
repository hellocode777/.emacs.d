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
  ;;"b" 'buffer-menu
  "b" 'magit-blame
  "f" 'counsel-find-file
  "g" 'counsel-git
  "k" 'kill-buffer
  "s" 'swiper
  "m" 'bm-toggle
  "l" 'bm-show-all
  "w" 'evil-window-map
  "<" 'zss-rg-dwim-project-dir
  ">" 'zssr-rg-dwim-project-dir
  "/" 'zss-rg-dwim-project-dir1
  "*" 'zs-rg-dwim-project-dir
  "&" 'zsr-rg-dwim-project-dir
  "d" 'delete-window
  "r" 'lsp-ui-peek-find-references
  "t" 'lsp-treemacs-references
  "o" 'lsp-treemacs-symbols
  "c" 'with-editor-async-shell-command
  "e" 'ff-find-related-file
  "j" 'ace-jump-word-mode
  "h" 'toggle-truncate-lines
  "," 'hs-hide-block
  "." 'hs-show-block
  ))

(use-package projectile
  :config
  (evil-leader/set-key "p" 'projectile-command-map))


(provide 'init-keybindings)

;;; init-keybindings.el ends here
